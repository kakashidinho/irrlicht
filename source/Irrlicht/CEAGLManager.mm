// Copyright (C) 2015 Patryk Nadrowski
// This file is part of the "Irrlicht Engine".
// For conditions of distribution and use, see copyright notice in Irrlicht.h

#include "CEAGLManager.h"

#ifdef _IRR_COMPILE_WITH_EAGL_MANAGER_

#include "irrString.h"
#include "os.h"

#import <UIKit/UIKit.h>
#import <MGLKit/MGLKit.h>

#if defined(_IRR_COMPILE_WITH_OGLES1_)
#include <GLES/gl.h>
#include <GLES/glext.h>
#elif defined(_IRR_COMPILE_WITH_OGLES2_)
#include <GLES2/gl2.h>
#include <GLES2/gl2ext.h>
#endif

namespace irr
{
namespace video
{

struct SEAGLManagerDataStorage
{
    SEAGLManagerDataStorage() : Layer(0), Context(0)
	{
	}

	MGLLayer* Layer;
	MGLContext* Context;
};

CEAGLManager::CEAGLManager() : IContextManager(), Configured(false), DataStorage(0)
{
#ifdef _DEBUG
	setDebugName("CEAGLManager");
#endif

	DataStorage = new SEAGLManagerDataStorage();
}

CEAGLManager::~CEAGLManager()
{
    destroyContext();
    destroySurface();
    terminate();

	delete static_cast<SEAGLManagerDataStorage*>(DataStorage);
}

bool CEAGLManager::initialize(const SIrrlichtCreationParameters& params, const SExposedVideoData& data)
{
	SEAGLManagerDataStorage* dataStorage = static_cast<SEAGLManagerDataStorage*>(DataStorage);

	if (dataStorage->Layer != nil)
        return true;

	Params = params;
	Data = data;

	UIView* view = (__bridge UIView*)data.OpenGLiOS.View;

	if (view == nil || ![[view layer] isKindOfClass:[MGLLayer class]])
	{
		os::Printer::log("Could not get EAGL display.");
		return false;
	}
	
	dataStorage->Layer = (MGLLayer*)[view layer];
	dataStorage->Layer.contentsScale = view.contentScaleFactor;

    return true;
}

void CEAGLManager::terminate()
{
	SEAGLManagerDataStorage* dataStorage = static_cast<SEAGLManagerDataStorage*>(DataStorage);
	
	[MGLContext setCurrentContext:0];
	
	destroySurface();

    if (dataStorage->Layer != nil)
        dataStorage->Layer = 0;
}

bool CEAGLManager::generateSurface()
{
	SEAGLManagerDataStorage* dataStorage = static_cast<SEAGLManagerDataStorage*>(DataStorage);
	MGLLayer* layer = dataStorage->Layer;
	
    if (layer == nil)
        return false;

	if (Configured)
		return true;

	[layer setOpaque:(Params.WithAlphaChannel) ? YES : NO];
	layer.drawableColorFormat   = (Params.Bits > 16) ? MGLDrawableColorFormatRGB565 :
        MGLDrawableColorFormatRGBA8888;
	layer.drawableDepthFormat   = MGLDrawableDepthFormat24;
	layer.drawableStencilFormat = MGLDrawableStencilFormat8;
	
	Configured = true;

    return true;
}

void CEAGLManager::destroySurface()
{
	SEAGLManagerDataStorage* dataStorage = static_cast<SEAGLManagerDataStorage*>(DataStorage);
	MGLLayer* layer = dataStorage->Layer;
	
	if (layer == nil)
		return;

	[layer setOpaque:NO];
	
	Configured = false;
}

bool CEAGLManager::generateContext()
{
	SEAGLManagerDataStorage* dataStorage = static_cast<SEAGLManagerDataStorage*>(DataStorage);

    if (dataStorage->Context != nil || !Configured)
        return false;

	MGLRenderingAPI OpenGLESVersion = kMGLRenderingAPIOpenGLES2;

	switch (Params.DriverType)
	{
	case EDT_OGLES1:
		OpenGLESVersion = kMGLRenderingAPIOpenGLES1;
		break;
	case EDT_OGLES2:
		OpenGLESVersion = kMGLRenderingAPIOpenGLES2;
		break;
	default:
		break;
	}

    if (OpenGLESVersion == kMGLRenderingAPIOpenGLES2) {
        dataStorage->Context = [[MGLContext alloc] initWithAPI: kMGLRenderingAPIOpenGLES3];

        if (dataStorage->Context == nil)
            dataStorage->Context = [[MGLContext alloc] initWithAPI: kMGLRenderingAPIOpenGLES2];
    } else {
        dataStorage->Context = [[MGLContext alloc] initWithAPI:OpenGLESVersion];
    }
    dataStorage->Context = [[MGLContext alloc] initWithAPI:OpenGLESVersion];

	if (dataStorage->Context == nil)
	{
		os::Printer::log("Could not create EAGL context.", ELL_ERROR);
		return false;
	}

	Data.OpenGLiOS.Context = (__bridge void*)dataStorage->Context;

	os::Printer::log("EAGL context created with OpenGLESVersion: ", core::stringc(static_cast<int>(OpenGLESVersion)), ELL_DEBUG);

    return true;
}

void CEAGLManager::destroyContext()
{
	SEAGLManagerDataStorage* dataStorage = static_cast<SEAGLManagerDataStorage*>(DataStorage);

	[MGLContext setCurrentContext:0];
	
    if (dataStorage->Context != nil)
        dataStorage->Context = 0;

	Data.OpenGLiOS.Context = 0;
}

bool CEAGLManager::activateContext(const SExposedVideoData& videoData, bool restorePrimaryOnZero)
{
	SEAGLManagerDataStorage* dataStorage = static_cast<SEAGLManagerDataStorage*>(DataStorage);
	MGLContext* context = dataStorage->Context;
	
	bool status = false;

	if (context != nil)
	{
		status = ([MGLContext currentContext] == context ||
				  [MGLContext setCurrentContext:context forLayer:dataStorage->Layer]);
	}

	if (status)
	{
	}
	else
	{
		os::Printer::log("Could not make EGL context current.");
	}

	return status;
}

const SExposedVideoData& CEAGLManager::getContext() const
{
	return Data;
}

bool CEAGLManager::swapBuffers()
{
	SEAGLManagerDataStorage* dataStorage = static_cast<SEAGLManagerDataStorage*>(DataStorage);
	MGLContext* context = dataStorage->Context;
	
	bool status = false;
	
	if (context != nil && context == [MGLContext currentContext])
	{
		status = [context present:dataStorage->Layer];
	}

    return status;
}

}
}

#endif
