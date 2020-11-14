// Copyright (C) 2020 Le Hoang Quyen
// This file is part of the "Irrlicht Engine".
// For conditions of distribution and use, see copyright notice in Irrlicht.h

#include "CMGLManager.h"

#ifdef _IRR_COMPILE_WITH_EAGL_MANAGER_

#include "irrString.h"
#include "os.h"

#include "CMGLOrEAGLFunctions.h"

#import <UIKit/UIKit.h>
#import <MGLKit/MGLKit.h>

namespace irr
{
namespace video
{

struct SMGLManagerDataStorage
{
    SMGLManagerDataStorage() : Layer(0), Context(0)
	{
	}

	MGLLayer* Layer;
	MGLContext* Context;
};

CMGLManager::CMGLManager() : IContextManager(), Configured(false), DataStorage(0)
{
#ifdef _DEBUG
	setDebugName("CMGLManager");
#endif

	DataStorage = new SMGLManagerDataStorage();
}

CMGLManager::~CMGLManager()
{
    destroyContext();
    destroySurface();
    terminate();

	delete static_cast<SMGLManagerDataStorage*>(DataStorage);
}

bool CMGLManager::initialize(const SIrrlichtCreationParameters& params, const SExposedVideoData& data)
{
	SMGLManagerDataStorage* dataStorage = static_cast<SMGLManagerDataStorage*>(DataStorage);

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

void CMGLManager::terminate()
{
	SMGLManagerDataStorage* dataStorage = static_cast<SMGLManagerDataStorage*>(DataStorage);
	
	[MGLContext setCurrentContext:0];
	
	destroySurface();

    if (dataStorage->Layer != nil)
        dataStorage->Layer = 0;
}

bool CMGLManager::generateSurface()
{
	SMGLManagerDataStorage* dataStorage = static_cast<SMGLManagerDataStorage*>(DataStorage);
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

void CMGLManager::destroySurface()
{
	SMGLManagerDataStorage* dataStorage = static_cast<SMGLManagerDataStorage*>(DataStorage);
	MGLLayer* layer = dataStorage->Layer;
	
	if (layer == nil)
		return;

	[layer setOpaque:NO];
	
	Configured = false;
}

bool CMGLManager::generateContext()
{
	SMGLManagerDataStorage* dataStorage = static_cast<SMGLManagerDataStorage*>(DataStorage);

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

void CMGLManager::destroyContext()
{
	SMGLManagerDataStorage* dataStorage = static_cast<SMGLManagerDataStorage*>(DataStorage);

	[MGLContext setCurrentContext:0];
	
    if (dataStorage->Context != nil)
        dataStorage->Context = 0;

	Data.OpenGLiOS.Context = 0;
}

bool CMGLManager::activateContext(const SExposedVideoData& videoData, bool restorePrimaryOnZero)
{
	SMGLManagerDataStorage* dataStorage = static_cast<SMGLManagerDataStorage*>(DataStorage);
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

const SExposedVideoData& CMGLManager::getContext() const
{
	return Data;
}

bool CMGLManager::swapBuffers()
{
	SMGLManagerDataStorage* dataStorage = static_cast<SMGLManagerDataStorage*>(DataStorage);
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
