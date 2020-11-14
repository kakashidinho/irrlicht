// Copyright (C) 2020 Le Hoang Quyen
// This file is part of the "Irrlicht Engine".
// For conditions of distribution and use, see copyright notice in Irrlicht.h

#include "CMGLOrEAGLFunctions.h"

#ifdef _IRR_COMPILE_WITH_EAGL_MANAGER_

#import <UIKit/UIKit.h>

#include <array>
#include <dlfcn.h>

Class EAGLContextClass;
const NSString *kEAGLColorFormatRGBA8Value;
const NSString *kEAGLColorFormatRGB565Value;
const NSString *kEAGLColorFormatSRGBA8Value;
const NSString *kEAGLDrawablePropertyRetainedBackingValue;
const NSString *kEAGLDrawablePropertyColorFormatValue;

PFNGLALPHAFUNCPROC glAlphaFuncPointer;
PFNGLCLIPPLANEFPROC glClipPlanefPointer;
PFNGLCOLOR4FPROC glColor4fPointer;
PFNGLFOGFPROC glFogfPointer;
PFNGLFOGFVPROC glFogfvPointer;
PFNGLFRUSTUMFPROC glFrustumfPointer;
PFNGLGETCLIPPLANEFPROC glGetClipPlanefPointer;
PFNGLGETLIGHTFVPROC glGetLightfvPointer;
PFNGLGETMATERIALFVPROC glGetMaterialfvPointer;
PFNGLGETTEXENVFVPROC glGetTexEnvfvPointer;
PFNGLLIGHTMODELFPROC glLightModelfPointer;
PFNGLLIGHTMODELFVPROC glLightModelfvPointer;
PFNGLLIGHTFPROC glLightfPointer;
PFNGLLIGHTFVPROC glLightfvPointer;
PFNGLLOADMATRIXFPROC glLoadMatrixfPointer;
PFNGLMATERIALFPROC glMaterialfPointer;
PFNGLMATERIALFVPROC glMaterialfvPointer;
PFNGLMULTMATRIXFPROC glMultMatrixfPointer;
PFNGLMULTITEXCOORD4FPROC glMultiTexCoord4fPointer;
PFNGLNORMAL3FPROC glNormal3fPointer;
PFNGLORTHOFPROC glOrthofPointer;
PFNGLPOINTPARAMETERFPROC glPointParameterfPointer;
PFNGLPOINTPARAMETERFVPROC glPointParameterfvPointer;
PFNGLPOINTSIZEPROC glPointSizePointer;
PFNGLROTATEFPROC glRotatefPointer;
PFNGLSCALEFPROC glScalefPointer;
PFNGLTEXENVFPROC glTexEnvfPointer;
PFNGLTEXENVFVPROC glTexEnvfvPointer;
PFNGLTRANSLATEFPROC glTranslatefPointer;
PFNGLALPHAFUNCXPROC glAlphaFuncxPointer;
PFNGLCLEARCOLORXPROC glClearColorxPointer;
PFNGLCLEARDEPTHXPROC glClearDepthxPointer;
PFNGLCLIENTACTIVETEXTUREPROC glClientActiveTexturePointer;
PFNGLCLIPPLANEXPROC glClipPlanexPointer;
PFNGLCOLOR4UBPROC glColor4ubPointer;
PFNGLCOLOR4XPROC glColor4xPointer;
PFNGLCOLORPOINTERPROC glColorPointerPointer;
PFNGLDEPTHRANGEXPROC glDepthRangexPointer;
PFNGLDISABLECLIENTSTATEPROC glDisableClientStatePointer;
PFNGLENABLECLIENTSTATEPROC glEnableClientStatePointer;
PFNGLFOGXPROC glFogxPointer;
PFNGLFOGXVPROC glFogxvPointer;
PFNGLFRUSTUMXPROC glFrustumxPointer;
PFNGLGETCLIPPLANEXPROC glGetClipPlanexPointer;
PFNGLGETFIXEDVPROC glGetFixedvPointer;
PFNGLGETLIGHTXVPROC glGetLightxvPointer;
PFNGLGETMATERIALXVPROC glGetMaterialxvPointer;
PFNGLGETPOINTERVPROC glGetPointervPointer;
PFNGLGETTEXENVIVPROC glGetTexEnvivPointer;
PFNGLGETTEXENVXVPROC glGetTexEnvxvPointer;
PFNGLGETTEXPARAMETERXVPROC glGetTexParameterxvPointer;
PFNGLLIGHTMODELXPROC glLightModelxPointer;
PFNGLLIGHTMODELXVPROC glLightModelxvPointer;
PFNGLLIGHTXPROC glLightxPointer;
PFNGLLIGHTXVPROC glLightxvPointer;
PFNGLLINEWIDTHXPROC glLineWidthxPointer;
PFNGLLOADIDENTITYPROC glLoadIdentityPointer;
PFNGLLOADMATRIXXPROC glLoadMatrixxPointer;
PFNGLLOGICOPPROC glLogicOpPointer;
PFNGLMATERIALXPROC glMaterialxPointer;
PFNGLMATERIALXVPROC glMaterialxvPointer;
PFNGLMATRIXMODEPROC glMatrixModePointer;
PFNGLMULTMATRIXXPROC glMultMatrixxPointer;
PFNGLMULTITEXCOORD4XPROC glMultiTexCoord4xPointer;
PFNGLNORMAL3XPROC glNormal3xPointer;
PFNGLNORMALPOINTERPROC glNormalPointerPointer;
PFNGLORTHOXPROC glOrthoxPointer;
PFNGLPOINTPARAMETERXPROC glPointParameterxPointer;
PFNGLPOINTPARAMETERXVPROC glPointParameterxvPointer;
PFNGLPOINTSIZEXPROC glPointSizexPointer;
PFNGLPOLYGONOFFSETXPROC glPolygonOffsetxPointer;
PFNGLPOPMATRIXPROC glPopMatrixPointer;
PFNGLPUSHMATRIXPROC glPushMatrixPointer;
PFNGLROTATEXPROC glRotatexPointer;
PFNGLSAMPLECOVERAGEXPROC glSampleCoveragexPointer;
PFNGLSCALEXPROC glScalexPointer;
PFNGLSHADEMODELPROC glShadeModelPointer;
PFNGLTEXCOORDPOINTERPROC glTexCoordPointerPointer;
PFNGLTEXENVIPROC glTexEnviPointer;
PFNGLTEXENVXPROC glTexEnvxPointer;
PFNGLTEXENVIVPROC glTexEnvivPointer;
PFNGLTEXENVXVPROC glTexEnvxvPointer;
PFNGLTEXPARAMETERXPROC glTexParameterxPointer;
PFNGLTEXPARAMETERXVPROC glTexParameterxvPointer;
PFNGLTRANSLATEXPROC glTranslatexPointer;
PFNGLVERTEXPOINTERPROC glVertexPointerPointer;
PFNGLACTIVETEXTUREPROC glActiveTexturePointer;
PFNGLATTACHSHADERPROC glAttachShaderPointer;
PFNGLBINDATTRIBLOCATIONPROC glBindAttribLocationPointer;
PFNGLBINDBUFFERPROC glBindBufferPointer;
PFNGLBINDFRAMEBUFFERPROC glBindFramebufferPointer;
PFNGLBINDRENDERBUFFERPROC glBindRenderbufferPointer;
PFNGLBINDTEXTUREPROC glBindTexturePointer;
PFNGLBLENDCOLORPROC glBlendColorPointer;
PFNGLBLENDEQUATIONPROC glBlendEquationPointer;
PFNGLBLENDEQUATIONSEPARATEPROC glBlendEquationSeparatePointer;
PFNGLBLENDFUNCPROC glBlendFuncPointer;
PFNGLBLENDFUNCSEPARATEPROC glBlendFuncSeparatePointer;
PFNGLBUFFERDATAPROC glBufferDataPointer;
PFNGLBUFFERSUBDATAPROC glBufferSubDataPointer;
PFNGLCHECKFRAMEBUFFERSTATUSPROC glCheckFramebufferStatusPointer;
PFNGLCLEARPROC glClearPointer;
PFNGLCLEARCOLORPROC glClearColorPointer;
PFNGLCLEARDEPTHFPROC glClearDepthfPointer;
PFNGLCLEARSTENCILPROC glClearStencilPointer;
PFNGLCOLORMASKPROC glColorMaskPointer;
PFNGLCOMPILESHADERPROC glCompileShaderPointer;
PFNGLCOMPRESSEDTEXIMAGE2DPROC glCompressedTexImage2DPointer;
PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC glCompressedTexSubImage2DPointer;
PFNGLCOPYTEXIMAGE2DPROC glCopyTexImage2DPointer;
PFNGLCOPYTEXSUBIMAGE2DPROC glCopyTexSubImage2DPointer;
PFNGLCREATEPROGRAMPROC glCreateProgramPointer;
PFNGLCREATESHADERPROC glCreateShaderPointer;
PFNGLCULLFACEPROC glCullFacePointer;
PFNGLDELETEBUFFERSPROC glDeleteBuffersPointer;
PFNGLDELETEFRAMEBUFFERSPROC glDeleteFramebuffersPointer;
PFNGLDELETEPROGRAMPROC glDeleteProgramPointer;
PFNGLDELETERENDERBUFFERSPROC glDeleteRenderbuffersPointer;
PFNGLDELETESHADERPROC glDeleteShaderPointer;
PFNGLDELETETEXTURESPROC glDeleteTexturesPointer;
PFNGLDEPTHFUNCPROC glDepthFuncPointer;
PFNGLDEPTHMASKPROC glDepthMaskPointer;
PFNGLDEPTHRANGEFPROC glDepthRangefPointer;
PFNGLDETACHSHADERPROC glDetachShaderPointer;
PFNGLDISABLEPROC glDisablePointer;
PFNGLDISABLEVERTEXATTRIBARRAYPROC glDisableVertexAttribArrayPointer;
PFNGLDRAWARRAYSPROC glDrawArraysPointer;
PFNGLDRAWELEMENTSPROC glDrawElementsPointer;
PFNGLENABLEPROC glEnablePointer;
PFNGLENABLEVERTEXATTRIBARRAYPROC glEnableVertexAttribArrayPointer;
PFNGLFINISHPROC glFinishPointer;
PFNGLFLUSHPROC glFlushPointer;
PFNGLFRAMEBUFFERRENDERBUFFERPROC glFramebufferRenderbufferPointer;
PFNGLFRAMEBUFFERTEXTURE2DPROC glFramebufferTexture2DPointer;
PFNGLFRONTFACEPROC glFrontFacePointer;
PFNGLGENBUFFERSPROC glGenBuffersPointer;
PFNGLGENERATEMIPMAPPROC glGenerateMipmapPointer;
PFNGLGENFRAMEBUFFERSPROC glGenFramebuffersPointer;
PFNGLGENRENDERBUFFERSPROC glGenRenderbuffersPointer;
PFNGLGENTEXTURESPROC glGenTexturesPointer;
PFNGLGETACTIVEATTRIBPROC glGetActiveAttribPointer;
PFNGLGETACTIVEUNIFORMPROC glGetActiveUniformPointer;
PFNGLGETATTACHEDSHADERSPROC glGetAttachedShadersPointer;
PFNGLGETATTRIBLOCATIONPROC glGetAttribLocationPointer;
PFNGLGETBOOLEANVPROC glGetBooleanvPointer;
PFNGLGETBUFFERPARAMETERIVPROC glGetBufferParameterivPointer;
PFNGLGETERRORPROC glGetErrorPointer;
PFNGLGETFLOATVPROC glGetFloatvPointer;
PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC glGetFramebufferAttachmentParameterivPointer;
PFNGLGETINTEGERVPROC glGetIntegervPointer;
PFNGLGETPROGRAMIVPROC glGetProgramivPointer;
PFNGLGETPROGRAMINFOLOGPROC glGetProgramInfoLogPointer;
PFNGLGETRENDERBUFFERPARAMETERIVPROC glGetRenderbufferParameterivPointer;
PFNGLGETSHADERIVPROC glGetShaderivPointer;
PFNGLGETSHADERINFOLOGPROC glGetShaderInfoLogPointer;
PFNGLGETSHADERPRECISIONFORMATPROC glGetShaderPrecisionFormatPointer;
PFNGLGETSHADERSOURCEPROC glGetShaderSourcePointer;
PFNGLGETSTRINGPROC glGetStringPointer;
PFNGLGETTEXPARAMETERFVPROC glGetTexParameterfvPointer;
PFNGLGETTEXPARAMETERIVPROC glGetTexParameterivPointer;
PFNGLGETUNIFORMFVPROC glGetUniformfvPointer;
PFNGLGETUNIFORMIVPROC glGetUniformivPointer;
PFNGLGETUNIFORMLOCATIONPROC glGetUniformLocationPointer;
PFNGLGETVERTEXATTRIBFVPROC glGetVertexAttribfvPointer;
PFNGLGETVERTEXATTRIBIVPROC glGetVertexAttribivPointer;
PFNGLGETVERTEXATTRIBPOINTERVPROC glGetVertexAttribPointervPointer;
PFNGLHINTPROC glHintPointer;
PFNGLISBUFFERPROC glIsBufferPointer;
PFNGLISENABLEDPROC glIsEnabledPointer;
PFNGLISFRAMEBUFFERPROC glIsFramebufferPointer;
PFNGLISPROGRAMPROC glIsProgramPointer;
PFNGLISRENDERBUFFERPROC glIsRenderbufferPointer;
PFNGLISSHADERPROC glIsShaderPointer;
PFNGLISTEXTUREPROC glIsTexturePointer;
PFNGLLINEWIDTHPROC glLineWidthPointer;
PFNGLLINKPROGRAMPROC glLinkProgramPointer;
PFNGLPIXELSTOREIPROC glPixelStoreiPointer;
PFNGLPOLYGONOFFSETPROC glPolygonOffsetPointer;
PFNGLREADPIXELSPROC glReadPixelsPointer;
PFNGLRELEASESHADERCOMPILERPROC glReleaseShaderCompilerPointer;
PFNGLRENDERBUFFERSTORAGEPROC glRenderbufferStoragePointer;
PFNGLSAMPLECOVERAGEPROC glSampleCoveragePointer;
PFNGLSCISSORPROC glScissorPointer;
PFNGLSHADERBINARYPROC glShaderBinaryPointer;
PFNGLSHADERSOURCEPROC glShaderSourcePointer;
PFNGLSTENCILFUNCPROC glStencilFuncPointer;
PFNGLSTENCILFUNCSEPARATEPROC glStencilFuncSeparatePointer;
PFNGLSTENCILMASKPROC glStencilMaskPointer;
PFNGLSTENCILMASKSEPARATEPROC glStencilMaskSeparatePointer;
PFNGLSTENCILOPPROC glStencilOpPointer;
PFNGLSTENCILOPSEPARATEPROC glStencilOpSeparatePointer;
PFNGLTEXIMAGE2DPROC glTexImage2DPointer;
PFNGLTEXPARAMETERFPROC glTexParameterfPointer;
PFNGLTEXPARAMETERFVPROC glTexParameterfvPointer;
PFNGLTEXPARAMETERIPROC glTexParameteriPointer;
PFNGLTEXPARAMETERIVPROC glTexParameterivPointer;
PFNGLTEXSUBIMAGE2DPROC glTexSubImage2DPointer;
PFNGLUNIFORM1FPROC glUniform1fPointer;
PFNGLUNIFORM1FVPROC glUniform1fvPointer;
PFNGLUNIFORM1IPROC glUniform1iPointer;
PFNGLUNIFORM1IVPROC glUniform1ivPointer;
PFNGLUNIFORM2FPROC glUniform2fPointer;
PFNGLUNIFORM2FVPROC glUniform2fvPointer;
PFNGLUNIFORM2IPROC glUniform2iPointer;
PFNGLUNIFORM2IVPROC glUniform2ivPointer;
PFNGLUNIFORM3FPROC glUniform3fPointer;
PFNGLUNIFORM3FVPROC glUniform3fvPointer;
PFNGLUNIFORM3IPROC glUniform3iPointer;
PFNGLUNIFORM3IVPROC glUniform3ivPointer;
PFNGLUNIFORM4FPROC glUniform4fPointer;
PFNGLUNIFORM4FVPROC glUniform4fvPointer;
PFNGLUNIFORM4IPROC glUniform4iPointer;
PFNGLUNIFORM4IVPROC glUniform4ivPointer;
PFNGLUNIFORMMATRIX2FVPROC glUniformMatrix2fvPointer;
PFNGLUNIFORMMATRIX3FVPROC glUniformMatrix3fvPointer;
PFNGLUNIFORMMATRIX4FVPROC glUniformMatrix4fvPointer;
PFNGLUSEPROGRAMPROC glUseProgramPointer;
PFNGLVALIDATEPROGRAMPROC glValidateProgramPointer;
PFNGLVERTEXATTRIB1FPROC glVertexAttrib1fPointer;
PFNGLVERTEXATTRIB1FVPROC glVertexAttrib1fvPointer;
PFNGLVERTEXATTRIB2FPROC glVertexAttrib2fPointer;
PFNGLVERTEXATTRIB2FVPROC glVertexAttrib2fvPointer;
PFNGLVERTEXATTRIB3FPROC glVertexAttrib3fPointer;
PFNGLVERTEXATTRIB3FVPROC glVertexAttrib3fvPointer;
PFNGLVERTEXATTRIB4FPROC glVertexAttrib4fPointer;
PFNGLVERTEXATTRIB4FVPROC glVertexAttrib4fvPointer;
PFNGLVERTEXATTRIBPOINTERPROC glVertexAttribPointerPointer;
PFNGLVIEWPORTPROC glViewportPointer;
PFNGLREADBUFFERPROC glReadBufferPointer;
PFNGLDRAWRANGEELEMENTSPROC glDrawRangeElementsPointer;
PFNGLTEXIMAGE3DPROC glTexImage3DPointer;
PFNGLTEXSUBIMAGE3DPROC glTexSubImage3DPointer;
PFNGLCOPYTEXSUBIMAGE3DPROC glCopyTexSubImage3DPointer;
PFNGLCOMPRESSEDTEXIMAGE3DPROC glCompressedTexImage3DPointer;
PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC glCompressedTexSubImage3DPointer;
PFNGLGENQUERIESPROC glGenQueriesPointer;
PFNGLDELETEQUERIESPROC glDeleteQueriesPointer;
PFNGLISQUERYPROC glIsQueryPointer;
PFNGLBEGINQUERYPROC glBeginQueryPointer;
PFNGLENDQUERYPROC glEndQueryPointer;
PFNGLGETQUERYIVPROC glGetQueryivPointer;
PFNGLGETQUERYOBJECTUIVPROC glGetQueryObjectuivPointer;
PFNGLUNMAPBUFFERPROC glUnmapBufferPointer;
PFNGLGETBUFFERPOINTERVPROC glGetBufferPointervPointer;
PFNGLDRAWBUFFERSPROC glDrawBuffersPointer;
PFNGLUNIFORMMATRIX2X3FVPROC glUniformMatrix2x3fvPointer;
PFNGLUNIFORMMATRIX3X2FVPROC glUniformMatrix3x2fvPointer;
PFNGLUNIFORMMATRIX2X4FVPROC glUniformMatrix2x4fvPointer;
PFNGLUNIFORMMATRIX4X2FVPROC glUniformMatrix4x2fvPointer;
PFNGLUNIFORMMATRIX3X4FVPROC glUniformMatrix3x4fvPointer;
PFNGLUNIFORMMATRIX4X3FVPROC glUniformMatrix4x3fvPointer;
PFNGLBLITFRAMEBUFFERPROC glBlitFramebufferPointer;
PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC glRenderbufferStorageMultisamplePointer;
PFNGLFRAMEBUFFERTEXTURELAYERPROC glFramebufferTextureLayerPointer;
PFNGLMAPBUFFERRANGEPROC glMapBufferRangePointer;
PFNGLFLUSHMAPPEDBUFFERRANGEPROC glFlushMappedBufferRangePointer;
PFNGLBINDVERTEXARRAYPROC glBindVertexArrayPointer;
PFNGLDELETEVERTEXARRAYSPROC glDeleteVertexArraysPointer;
PFNGLGENVERTEXARRAYSPROC glGenVertexArraysPointer;
PFNGLISVERTEXARRAYPROC glIsVertexArrayPointer;
PFNGLGETINTEGERI_VPROC glGetIntegeri_vPointer;
PFNGLBEGINTRANSFORMFEEDBACKPROC glBeginTransformFeedbackPointer;
PFNGLENDTRANSFORMFEEDBACKPROC glEndTransformFeedbackPointer;
PFNGLBINDBUFFERRANGEPROC glBindBufferRangePointer;
PFNGLBINDBUFFERBASEPROC glBindBufferBasePointer;
PFNGLTRANSFORMFEEDBACKVARYINGSPROC glTransformFeedbackVaryingsPointer;
PFNGLGETTRANSFORMFEEDBACKVARYINGPROC glGetTransformFeedbackVaryingPointer;
PFNGLVERTEXATTRIBIPOINTERPROC glVertexAttribIPointerPointer;
PFNGLGETVERTEXATTRIBIIVPROC glGetVertexAttribIivPointer;
PFNGLGETVERTEXATTRIBIUIVPROC glGetVertexAttribIuivPointer;
PFNGLVERTEXATTRIBI4IPROC glVertexAttribI4iPointer;
PFNGLVERTEXATTRIBI4UIPROC glVertexAttribI4uiPointer;
PFNGLVERTEXATTRIBI4IVPROC glVertexAttribI4ivPointer;
PFNGLVERTEXATTRIBI4UIVPROC glVertexAttribI4uivPointer;
PFNGLGETUNIFORMUIVPROC glGetUniformuivPointer;
PFNGLGETFRAGDATALOCATIONPROC glGetFragDataLocationPointer;
PFNGLUNIFORM1UIPROC glUniform1uiPointer;
PFNGLUNIFORM2UIPROC glUniform2uiPointer;
PFNGLUNIFORM3UIPROC glUniform3uiPointer;
PFNGLUNIFORM4UIPROC glUniform4uiPointer;
PFNGLUNIFORM1UIVPROC glUniform1uivPointer;
PFNGLUNIFORM2UIVPROC glUniform2uivPointer;
PFNGLUNIFORM3UIVPROC glUniform3uivPointer;
PFNGLUNIFORM4UIVPROC glUniform4uivPointer;
PFNGLCLEARBUFFERIVPROC glClearBufferivPointer;
PFNGLCLEARBUFFERUIVPROC glClearBufferuivPointer;
PFNGLCLEARBUFFERFVPROC glClearBufferfvPointer;
PFNGLCLEARBUFFERFIPROC glClearBufferfiPointer;
PFNGLGETSTRINGIPROC glGetStringiPointer;
PFNGLCOPYBUFFERSUBDATAPROC glCopyBufferSubDataPointer;
PFNGLGETUNIFORMINDICESPROC glGetUniformIndicesPointer;
PFNGLGETACTIVEUNIFORMSIVPROC glGetActiveUniformsivPointer;
PFNGLGETUNIFORMBLOCKINDEXPROC glGetUniformBlockIndexPointer;
PFNGLGETACTIVEUNIFORMBLOCKIVPROC glGetActiveUniformBlockivPointer;
PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC glGetActiveUniformBlockNamePointer;
PFNGLUNIFORMBLOCKBINDINGPROC glUniformBlockBindingPointer;
PFNGLDRAWARRAYSINSTANCEDPROC glDrawArraysInstancedPointer;
PFNGLDRAWELEMENTSINSTANCEDPROC glDrawElementsInstancedPointer;
PFNGLFENCESYNCPROC glFenceSyncPointer;
PFNGLISSYNCPROC glIsSyncPointer;
PFNGLDELETESYNCPROC glDeleteSyncPointer;
PFNGLCLIENTWAITSYNCPROC glClientWaitSyncPointer;
PFNGLWAITSYNCPROC glWaitSyncPointer;
PFNGLGETINTEGER64VPROC glGetInteger64vPointer;
PFNGLGETSYNCIVPROC glGetSyncivPointer;
PFNGLGETINTEGER64I_VPROC glGetInteger64i_vPointer;
PFNGLGETBUFFERPARAMETERI64VPROC glGetBufferParameteri64vPointer;
PFNGLGENSAMPLERSPROC glGenSamplersPointer;
PFNGLDELETESAMPLERSPROC glDeleteSamplersPointer;
PFNGLISSAMPLERPROC glIsSamplerPointer;
PFNGLBINDSAMPLERPROC glBindSamplerPointer;
PFNGLSAMPLERPARAMETERIPROC glSamplerParameteriPointer;
PFNGLSAMPLERPARAMETERIVPROC glSamplerParameterivPointer;
PFNGLSAMPLERPARAMETERFPROC glSamplerParameterfPointer;
PFNGLSAMPLERPARAMETERFVPROC glSamplerParameterfvPointer;
PFNGLGETSAMPLERPARAMETERIVPROC glGetSamplerParameterivPointer;
PFNGLGETSAMPLERPARAMETERFVPROC glGetSamplerParameterfvPointer;
PFNGLVERTEXATTRIBDIVISORPROC glVertexAttribDivisorPointer;
PFNGLBINDTRANSFORMFEEDBACKPROC glBindTransformFeedbackPointer;
PFNGLDELETETRANSFORMFEEDBACKSPROC glDeleteTransformFeedbacksPointer;
PFNGLGENTRANSFORMFEEDBACKSPROC glGenTransformFeedbacksPointer;
PFNGLISTRANSFORMFEEDBACKPROC glIsTransformFeedbackPointer;
PFNGLPAUSETRANSFORMFEEDBACKPROC glPauseTransformFeedbackPointer;
PFNGLRESUMETRANSFORMFEEDBACKPROC glResumeTransformFeedbackPointer;
PFNGLGETPROGRAMBINARYPROC glGetProgramBinaryPointer;
PFNGLPROGRAMBINARYPROC glProgramBinaryPointer;
PFNGLPROGRAMPARAMETERIPROC glProgramParameteriPointer;
PFNGLINVALIDATEFRAMEBUFFERPROC glInvalidateFramebufferPointer;
PFNGLINVALIDATESUBFRAMEBUFFERPROC glInvalidateSubFramebufferPointer;
PFNGLTEXSTORAGE2DPROC glTexStorage2DPointer;
PFNGLTEXSTORAGE3DPROC glTexStorage3DPointer;
PFNGLGETINTERNALFORMATIVPROC glGetInternalformativPointer;
PFNGLDISPATCHCOMPUTEPROC glDispatchComputePointer;
PFNGLDISPATCHCOMPUTEINDIRECTPROC glDispatchComputeIndirectPointer;
PFNGLDRAWARRAYSINDIRECTPROC glDrawArraysIndirectPointer;
PFNGLDRAWELEMENTSINDIRECTPROC glDrawElementsIndirectPointer;
PFNGLFRAMEBUFFERPARAMETERIPROC glFramebufferParameteriPointer;
PFNGLGETFRAMEBUFFERPARAMETERIVPROC glGetFramebufferParameterivPointer;
PFNGLGETPROGRAMINTERFACEIVPROC glGetProgramInterfaceivPointer;
PFNGLGETPROGRAMRESOURCEINDEXPROC glGetProgramResourceIndexPointer;
PFNGLGETPROGRAMRESOURCENAMEPROC glGetProgramResourceNamePointer;
PFNGLGETPROGRAMRESOURCEIVPROC glGetProgramResourceivPointer;
PFNGLGETPROGRAMRESOURCELOCATIONPROC glGetProgramResourceLocationPointer;
PFNGLUSEPROGRAMSTAGESPROC glUseProgramStagesPointer;
PFNGLACTIVESHADERPROGRAMPROC glActiveShaderProgramPointer;
PFNGLCREATESHADERPROGRAMVPROC glCreateShaderProgramvPointer;
PFNGLBINDPROGRAMPIPELINEPROC glBindProgramPipelinePointer;
PFNGLDELETEPROGRAMPIPELINESPROC glDeleteProgramPipelinesPointer;
PFNGLGENPROGRAMPIPELINESPROC glGenProgramPipelinesPointer;
PFNGLISPROGRAMPIPELINEPROC glIsProgramPipelinePointer;
PFNGLGETPROGRAMPIPELINEIVPROC glGetProgramPipelineivPointer;
PFNGLPROGRAMUNIFORM1IPROC glProgramUniform1iPointer;
PFNGLPROGRAMUNIFORM2IPROC glProgramUniform2iPointer;
PFNGLPROGRAMUNIFORM3IPROC glProgramUniform3iPointer;
PFNGLPROGRAMUNIFORM4IPROC glProgramUniform4iPointer;
PFNGLPROGRAMUNIFORM1UIPROC glProgramUniform1uiPointer;
PFNGLPROGRAMUNIFORM2UIPROC glProgramUniform2uiPointer;
PFNGLPROGRAMUNIFORM3UIPROC glProgramUniform3uiPointer;
PFNGLPROGRAMUNIFORM4UIPROC glProgramUniform4uiPointer;
PFNGLPROGRAMUNIFORM1FPROC glProgramUniform1fPointer;
PFNGLPROGRAMUNIFORM2FPROC glProgramUniform2fPointer;
PFNGLPROGRAMUNIFORM3FPROC glProgramUniform3fPointer;
PFNGLPROGRAMUNIFORM4FPROC glProgramUniform4fPointer;
PFNGLPROGRAMUNIFORM1IVPROC glProgramUniform1ivPointer;
PFNGLPROGRAMUNIFORM2IVPROC glProgramUniform2ivPointer;
PFNGLPROGRAMUNIFORM3IVPROC glProgramUniform3ivPointer;
PFNGLPROGRAMUNIFORM4IVPROC glProgramUniform4ivPointer;
PFNGLPROGRAMUNIFORM1UIVPROC glProgramUniform1uivPointer;
PFNGLPROGRAMUNIFORM2UIVPROC glProgramUniform2uivPointer;
PFNGLPROGRAMUNIFORM3UIVPROC glProgramUniform3uivPointer;
PFNGLPROGRAMUNIFORM4UIVPROC glProgramUniform4uivPointer;
PFNGLPROGRAMUNIFORM1FVPROC glProgramUniform1fvPointer;
PFNGLPROGRAMUNIFORM2FVPROC glProgramUniform2fvPointer;
PFNGLPROGRAMUNIFORM3FVPROC glProgramUniform3fvPointer;
PFNGLPROGRAMUNIFORM4FVPROC glProgramUniform4fvPointer;
PFNGLPROGRAMUNIFORMMATRIX2FVPROC glProgramUniformMatrix2fvPointer;
PFNGLPROGRAMUNIFORMMATRIX3FVPROC glProgramUniformMatrix3fvPointer;
PFNGLPROGRAMUNIFORMMATRIX4FVPROC glProgramUniformMatrix4fvPointer;
PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC glProgramUniformMatrix2x3fvPointer;
PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC glProgramUniformMatrix3x2fvPointer;
PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC glProgramUniformMatrix2x4fvPointer;
PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC glProgramUniformMatrix4x2fvPointer;
PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC glProgramUniformMatrix3x4fvPointer;
PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC glProgramUniformMatrix4x3fvPointer;
PFNGLVALIDATEPROGRAMPIPELINEPROC glValidateProgramPipelinePointer;
PFNGLGETPROGRAMPIPELINEINFOLOGPROC glGetProgramPipelineInfoLogPointer;
PFNGLBINDIMAGETEXTUREPROC glBindImageTexturePointer;
PFNGLGETBOOLEANI_VPROC glGetBooleani_vPointer;
PFNGLMEMORYBARRIERPROC glMemoryBarrierPointer;
PFNGLMEMORYBARRIERBYREGIONPROC glMemoryBarrierByRegionPointer;
PFNGLTEXSTORAGE2DMULTISAMPLEPROC glTexStorage2DMultisamplePointer;
PFNGLGETMULTISAMPLEFVPROC glGetMultisamplefvPointer;
PFNGLSAMPLEMASKIPROC glSampleMaskiPointer;
PFNGLGETTEXLEVELPARAMETERIVPROC glGetTexLevelParameterivPointer;
PFNGLGETTEXLEVELPARAMETERFVPROC glGetTexLevelParameterfvPointer;
PFNGLBINDVERTEXBUFFERPROC glBindVertexBufferPointer;
PFNGLVERTEXATTRIBFORMATPROC glVertexAttribFormatPointer;
PFNGLVERTEXATTRIBIFORMATPROC glVertexAttribIFormatPointer;
PFNGLVERTEXATTRIBBINDINGPROC glVertexAttribBindingPointer;
PFNGLVERTEXBINDINGDIVISORPROC glVertexBindingDivisorPointer;

PFNGLBINDFRAMEBUFFEROESPROC glBindFramebufferOESPointer;
PFNGLBINDRENDERBUFFEROESPROC glBindRenderbufferOESPointer;
PFNGLCHECKFRAMEBUFFERSTATUSOESPROC glCheckFramebufferStatusOESPointer;
PFNGLDELETEFRAMEBUFFERSOESPROC glDeleteFramebuffersOESPointer;
PFNGLDELETERENDERBUFFERSOESPROC glDeleteRenderbuffersOESPointer;
PFNGLFRAMEBUFFERRENDERBUFFEROESPROC glFramebufferRenderbufferOESPointer;
PFNGLFRAMEBUFFERTEXTURE2DOESPROC glFramebufferTexture2DOESPointer;
PFNGLGENFRAMEBUFFERSOESPROC glGenFramebuffersOESPointer;
PFNGLGENRENDERBUFFERSOESPROC glGenRenderbuffersOESPointer;
PFNGLGENERATEMIPMAPOESPROC glGenerateMipmapOESPointer;
PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVOESPROC glGetFramebufferAttachmentParameterivOESPointer;
PFNGLGETRENDERBUFFERPARAMETERIVOESPROC glGetRenderbufferParameterivOESPointer;
PFNGLISFRAMEBUFFEROESPROC glIsFramebufferOESPointer;
PFNGLISRENDERBUFFEROESPROC glIsRenderbufferOESPointer;
PFNGLRENDERBUFFERSTORAGEOESPROC glRenderbufferStorageOESPointer;

PFNGLBLENDFUNCSEPARATEPROC glBlendFuncSeparateOESPointer;
PFNGLBLENDEQUATIONPROC glBlendEquationOESPointer;

namespace irr
{
namespace video
{
namespace mgl_eagl
{

void load(bool fromMGL)
{
    const char *kMetalANGLEName = "MetalANGLE.framework/MetalANGLE";
	const char *kOpenGLESDylibNames[] = {"/System/Library/Frameworks/OpenGLES.framework/OpenGLES",
									     "OpenGLES.framework/OpenGLES"};

    static void *sCachedHandles[2] = { nullptr, nullptr };
	void *&handle = sCachedHandles[fromMGL ? 1 : 0];

    const auto loadProc = [&handle](const char *name) { return dlsym(handle, name); };

    if (!handle)
    {
        if (fromMGL)
        {
            // MetalANGLE
            handle = dlopen(kMetalANGLEName, RTLD_NOW);
        }
        else
        {
            // Native GLES
            for (const char *glesLibNamePointer : kOpenGLESDylibNames)
            {
                handle = dlopen(glesLibNamePointer, RTLD_NOW);
                if (handle)
                {
                    break;
                }
            }

            EAGLContextClass = NSClassFromString(@"EAGLContext");

            const auto loadStringConst = [loadProc](const char *name) -> NSString *
            {
                auto stringPtr = reinterpret_cast<CFStringRef *>(loadProc(name));
                if (!stringPtr)
                {
                    return nil;
                }
                return (__bridge NSString *)(*stringPtr);
            };

            kEAGLColorFormatRGBA8Value = loadStringConst("kEAGLColorFormatRGBA8");
            kEAGLColorFormatRGB565Value = loadStringConst("kEAGLColorFormatRGB565");
            kEAGLColorFormatSRGBA8Value = loadStringConst("kEAGLColorFormatSRGBA8");
            kEAGLDrawablePropertyRetainedBackingValue = loadStringConst("kEAGLDrawablePropertyRetainedBacking");
            kEAGLDrawablePropertyColorFormatValue = loadStringConst("kEAGLDrawablePropertyColorFormat");
        }
    }  // if (!handle)

	glAlphaFuncPointer       = reinterpret_cast<PFNGLALPHAFUNCPROC>(loadProc("glAlphaFunc"));
    glClipPlanefPointer      = reinterpret_cast<PFNGLCLIPPLANEFPROC>(loadProc("glClipPlanef"));
    glColor4fPointer         = reinterpret_cast<PFNGLCOLOR4FPROC>(loadProc("glColor4f"));
    glFogfPointer            = reinterpret_cast<PFNGLFOGFPROC>(loadProc("glFogf"));
    glFogfvPointer           = reinterpret_cast<PFNGLFOGFVPROC>(loadProc("glFogfv"));
    glFrustumfPointer        = reinterpret_cast<PFNGLFRUSTUMFPROC>(loadProc("glFrustumf"));
    glGetClipPlanefPointer   = reinterpret_cast<PFNGLGETCLIPPLANEFPROC>(loadProc("glGetClipPlanef"));
    glGetLightfvPointer      = reinterpret_cast<PFNGLGETLIGHTFVPROC>(loadProc("glGetLightfv"));
    glGetMaterialfvPointer   = reinterpret_cast<PFNGLGETMATERIALFVPROC>(loadProc("glGetMaterialfv"));
    glGetTexEnvfvPointer     = reinterpret_cast<PFNGLGETTEXENVFVPROC>(loadProc("glGetTexEnvfv"));
    glLightModelfPointer     = reinterpret_cast<PFNGLLIGHTMODELFPROC>(loadProc("glLightModelf"));
    glLightModelfvPointer    = reinterpret_cast<PFNGLLIGHTMODELFVPROC>(loadProc("glLightModelfv"));
    glLightfPointer          = reinterpret_cast<PFNGLLIGHTFPROC>(loadProc("glLightf"));
    glLightfvPointer         = reinterpret_cast<PFNGLLIGHTFVPROC>(loadProc("glLightfv"));
    glLoadMatrixfPointer     = reinterpret_cast<PFNGLLOADMATRIXFPROC>(loadProc("glLoadMatrixf"));
    glMaterialfPointer       = reinterpret_cast<PFNGLMATERIALFPROC>(loadProc("glMaterialf"));
    glMaterialfvPointer      = reinterpret_cast<PFNGLMATERIALFVPROC>(loadProc("glMaterialfv"));
    glMultMatrixfPointer     = reinterpret_cast<PFNGLMULTMATRIXFPROC>(loadProc("glMultMatrixf"));
    glMultiTexCoord4fPointer = reinterpret_cast<PFNGLMULTITEXCOORD4FPROC>(loadProc("glMultiTexCoord4f"));
    glNormal3fPointer        = reinterpret_cast<PFNGLNORMAL3FPROC>(loadProc("glNormal3f"));
    glOrthofPointer          = reinterpret_cast<PFNGLORTHOFPROC>(loadProc("glOrthof"));
    glPointParameterfPointer = reinterpret_cast<PFNGLPOINTPARAMETERFPROC>(loadProc("glPointParameterf"));
    glPointParameterfvPointer =
        reinterpret_cast<PFNGLPOINTPARAMETERFVPROC>(loadProc("glPointParameterfv"));
    glPointSizePointer   = reinterpret_cast<PFNGLPOINTSIZEPROC>(loadProc("glPointSize"));
    glRotatefPointer     = reinterpret_cast<PFNGLROTATEFPROC>(loadProc("glRotatef"));
    glScalefPointer      = reinterpret_cast<PFNGLSCALEFPROC>(loadProc("glScalef"));
    glTexEnvfPointer     = reinterpret_cast<PFNGLTEXENVFPROC>(loadProc("glTexEnvf"));
    glTexEnvfvPointer    = reinterpret_cast<PFNGLTEXENVFVPROC>(loadProc("glTexEnvfv"));
    glTranslatefPointer  = reinterpret_cast<PFNGLTRANSLATEFPROC>(loadProc("glTranslatef"));
    glAlphaFuncxPointer  = reinterpret_cast<PFNGLALPHAFUNCXPROC>(loadProc("glAlphaFuncx"));
    glClearColorxPointer = reinterpret_cast<PFNGLCLEARCOLORXPROC>(loadProc("glClearColorx"));
    glClearDepthxPointer = reinterpret_cast<PFNGLCLEARDEPTHXPROC>(loadProc("glClearDepthx"));
    glClientActiveTexturePointer =
        reinterpret_cast<PFNGLCLIENTACTIVETEXTUREPROC>(loadProc("glClientActiveTexture"));
    glClipPlanexPointer   = reinterpret_cast<PFNGLCLIPPLANEXPROC>(loadProc("glClipPlanex"));
    glColor4ubPointer     = reinterpret_cast<PFNGLCOLOR4UBPROC>(loadProc("glColor4ub"));
    glColor4xPointer      = reinterpret_cast<PFNGLCOLOR4XPROC>(loadProc("glColor4x"));
    glColorPointerPointer = reinterpret_cast<PFNGLCOLORPOINTERPROC>(loadProc("glColorPointer"));
    glDepthRangexPointer  = reinterpret_cast<PFNGLDEPTHRANGEXPROC>(loadProc("glDepthRangex"));
    glDisableClientStatePointer =
        reinterpret_cast<PFNGLDISABLECLIENTSTATEPROC>(loadProc("glDisableClientState"));
    glEnableClientStatePointer =
        reinterpret_cast<PFNGLENABLECLIENTSTATEPROC>(loadProc("glEnableClientState"));
    glFogxPointer          = reinterpret_cast<PFNGLFOGXPROC>(loadProc("glFogx"));
    glFogxvPointer         = reinterpret_cast<PFNGLFOGXVPROC>(loadProc("glFogxv"));
    glFrustumxPointer      = reinterpret_cast<PFNGLFRUSTUMXPROC>(loadProc("glFrustumx"));
    glGetClipPlanexPointer = reinterpret_cast<PFNGLGETCLIPPLANEXPROC>(loadProc("glGetClipPlanex"));
    glGetFixedvPointer     = reinterpret_cast<PFNGLGETFIXEDVPROC>(loadProc("glGetFixedv"));
    glGetLightxvPointer    = reinterpret_cast<PFNGLGETLIGHTXVPROC>(loadProc("glGetLightxv"));
    glGetMaterialxvPointer = reinterpret_cast<PFNGLGETMATERIALXVPROC>(loadProc("glGetMaterialxv"));
    glGetPointervPointer   = reinterpret_cast<PFNGLGETPOINTERVPROC>(loadProc("glGetPointerv"));
    glGetTexEnvivPointer   = reinterpret_cast<PFNGLGETTEXENVIVPROC>(loadProc("glGetTexEnviv"));
    glGetTexEnvxvPointer   = reinterpret_cast<PFNGLGETTEXENVXVPROC>(loadProc("glGetTexEnvxv"));
    glGetTexParameterxvPointer =
        reinterpret_cast<PFNGLGETTEXPARAMETERXVPROC>(loadProc("glGetTexParameterxv"));
    glLightModelxPointer     = reinterpret_cast<PFNGLLIGHTMODELXPROC>(loadProc("glLightModelx"));
    glLightModelxvPointer    = reinterpret_cast<PFNGLLIGHTMODELXVPROC>(loadProc("glLightModelxv"));
    glLightxPointer          = reinterpret_cast<PFNGLLIGHTXPROC>(loadProc("glLightx"));
    glLightxvPointer         = reinterpret_cast<PFNGLLIGHTXVPROC>(loadProc("glLightxv"));
    glLineWidthxPointer      = reinterpret_cast<PFNGLLINEWIDTHXPROC>(loadProc("glLineWidthx"));
    glLoadIdentityPointer    = reinterpret_cast<PFNGLLOADIDENTITYPROC>(loadProc("glLoadIdentity"));
    glLoadMatrixxPointer     = reinterpret_cast<PFNGLLOADMATRIXXPROC>(loadProc("glLoadMatrixx"));
    glLogicOpPointer         = reinterpret_cast<PFNGLLOGICOPPROC>(loadProc("glLogicOp"));
    glMaterialxPointer       = reinterpret_cast<PFNGLMATERIALXPROC>(loadProc("glMaterialx"));
    glMaterialxvPointer      = reinterpret_cast<PFNGLMATERIALXVPROC>(loadProc("glMaterialxv"));
    glMatrixModePointer      = reinterpret_cast<PFNGLMATRIXMODEPROC>(loadProc("glMatrixMode"));
    glMultMatrixxPointer     = reinterpret_cast<PFNGLMULTMATRIXXPROC>(loadProc("glMultMatrixx"));
    glMultiTexCoord4xPointer = reinterpret_cast<PFNGLMULTITEXCOORD4XPROC>(loadProc("glMultiTexCoord4x"));
    glNormal3xPointer        = reinterpret_cast<PFNGLNORMAL3XPROC>(loadProc("glNormal3x"));
    glNormalPointerPointer   = reinterpret_cast<PFNGLNORMALPOINTERPROC>(loadProc("glNormalPointer"));
    glOrthoxPointer          = reinterpret_cast<PFNGLORTHOXPROC>(loadProc("glOrthox"));
    glPointParameterxPointer = reinterpret_cast<PFNGLPOINTPARAMETERXPROC>(loadProc("glPointParameterx"));
    glPointParameterxvPointer =
        reinterpret_cast<PFNGLPOINTPARAMETERXVPROC>(loadProc("glPointParameterxv"));
    glPointSizexPointer      = reinterpret_cast<PFNGLPOINTSIZEXPROC>(loadProc("glPointSizex"));
    glPolygonOffsetxPointer  = reinterpret_cast<PFNGLPOLYGONOFFSETXPROC>(loadProc("glPolygonOffsetx"));
    glPopMatrixPointer       = reinterpret_cast<PFNGLPOPMATRIXPROC>(loadProc("glPopMatrix"));
    glPushMatrixPointer      = reinterpret_cast<PFNGLPUSHMATRIXPROC>(loadProc("glPushMatrix"));
    glRotatexPointer         = reinterpret_cast<PFNGLROTATEXPROC>(loadProc("glRotatex"));
    glSampleCoveragexPointer = reinterpret_cast<PFNGLSAMPLECOVERAGEXPROC>(loadProc("glSampleCoveragex"));
    glScalexPointer          = reinterpret_cast<PFNGLSCALEXPROC>(loadProc("glScalex"));
    glShadeModelPointer      = reinterpret_cast<PFNGLSHADEMODELPROC>(loadProc("glShadeModel"));
    glTexCoordPointerPointer = reinterpret_cast<PFNGLTEXCOORDPOINTERPROC>(loadProc("glTexCoordPointer"));
    glTexEnviPointer         = reinterpret_cast<PFNGLTEXENVIPROC>(loadProc("glTexEnvi"));
    glTexEnvxPointer         = reinterpret_cast<PFNGLTEXENVXPROC>(loadProc("glTexEnvx"));
    glTexEnvivPointer        = reinterpret_cast<PFNGLTEXENVIVPROC>(loadProc("glTexEnviv"));
    glTexEnvxvPointer        = reinterpret_cast<PFNGLTEXENVXVPROC>(loadProc("glTexEnvxv"));
    glTexParameterxPointer   = reinterpret_cast<PFNGLTEXPARAMETERXPROC>(loadProc("glTexParameterx"));
    glTexParameterxvPointer  = reinterpret_cast<PFNGLTEXPARAMETERXVPROC>(loadProc("glTexParameterxv"));
    glTranslatexPointer      = reinterpret_cast<PFNGLTRANSLATEXPROC>(loadProc("glTranslatex"));
    glVertexPointerPointer   = reinterpret_cast<PFNGLVERTEXPOINTERPROC>(loadProc("glVertexPointer"));
    glActiveTexturePointer   = reinterpret_cast<PFNGLACTIVETEXTUREPROC>(loadProc("glActiveTexture"));
    glAttachShaderPointer    = reinterpret_cast<PFNGLATTACHSHADERPROC>(loadProc("glAttachShader"));
    glBindAttribLocationPointer =
        reinterpret_cast<PFNGLBINDATTRIBLOCATIONPROC>(loadProc("glBindAttribLocation"));
    glBindBufferPointer      = reinterpret_cast<PFNGLBINDBUFFERPROC>(loadProc("glBindBuffer"));
    glBindFramebufferPointer = reinterpret_cast<PFNGLBINDFRAMEBUFFERPROC>(loadProc("glBindFramebuffer"));
    glBindRenderbufferPointer =
        reinterpret_cast<PFNGLBINDRENDERBUFFERPROC>(loadProc("glBindRenderbuffer"));
    glBindTexturePointer   = reinterpret_cast<PFNGLBINDTEXTUREPROC>(loadProc("glBindTexture"));
    glBlendColorPointer    = reinterpret_cast<PFNGLBLENDCOLORPROC>(loadProc("glBlendColor"));
    glBlendEquationPointer = reinterpret_cast<PFNGLBLENDEQUATIONPROC>(loadProc("glBlendEquation"));
    glBlendEquationSeparatePointer =
        reinterpret_cast<PFNGLBLENDEQUATIONSEPARATEPROC>(loadProc("glBlendEquationSeparate"));
    glBlendFuncPointer = reinterpret_cast<PFNGLBLENDFUNCPROC>(loadProc("glBlendFunc"));
    glBlendFuncSeparatePointer =
        reinterpret_cast<PFNGLBLENDFUNCSEPARATEPROC>(loadProc("glBlendFuncSeparate"));
    glBufferDataPointer    = reinterpret_cast<PFNGLBUFFERDATAPROC>(loadProc("glBufferData"));
    glBufferSubDataPointer = reinterpret_cast<PFNGLBUFFERSUBDATAPROC>(loadProc("glBufferSubData"));
    glCheckFramebufferStatusPointer =
        reinterpret_cast<PFNGLCHECKFRAMEBUFFERSTATUSPROC>(loadProc("glCheckFramebufferStatus"));
    glClearPointer         = reinterpret_cast<PFNGLCLEARPROC>(loadProc("glClear"));
    glClearColorPointer    = reinterpret_cast<PFNGLCLEARCOLORPROC>(loadProc("glClearColor"));
    glClearDepthfPointer   = reinterpret_cast<PFNGLCLEARDEPTHFPROC>(loadProc("glClearDepthf"));
    glClearStencilPointer  = reinterpret_cast<PFNGLCLEARSTENCILPROC>(loadProc("glClearStencil"));
    glColorMaskPointer     = reinterpret_cast<PFNGLCOLORMASKPROC>(loadProc("glColorMask"));
    glCompileShaderPointer = reinterpret_cast<PFNGLCOMPILESHADERPROC>(loadProc("glCompileShader"));
    glCompressedTexImage2DPointer =
        reinterpret_cast<PFNGLCOMPRESSEDTEXIMAGE2DPROC>(loadProc("glCompressedTexImage2D"));
    glCompressedTexSubImage2DPointer =
        reinterpret_cast<PFNGLCOMPRESSEDTEXSUBIMAGE2DPROC>(loadProc("glCompressedTexSubImage2D"));
    glCopyTexImage2DPointer = reinterpret_cast<PFNGLCOPYTEXIMAGE2DPROC>(loadProc("glCopyTexImage2D"));
    glCopyTexSubImage2DPointer =
        reinterpret_cast<PFNGLCOPYTEXSUBIMAGE2DPROC>(loadProc("glCopyTexSubImage2D"));
    glCreateProgramPointer = reinterpret_cast<PFNGLCREATEPROGRAMPROC>(loadProc("glCreateProgram"));
    glCreateShaderPointer  = reinterpret_cast<PFNGLCREATESHADERPROC>(loadProc("glCreateShader"));
    glCullFacePointer      = reinterpret_cast<PFNGLCULLFACEPROC>(loadProc("glCullFace"));
    glDeleteBuffersPointer = reinterpret_cast<PFNGLDELETEBUFFERSPROC>(loadProc("glDeleteBuffers"));
    glDeleteFramebuffersPointer =
        reinterpret_cast<PFNGLDELETEFRAMEBUFFERSPROC>(loadProc("glDeleteFramebuffers"));
    glDeleteProgramPointer = reinterpret_cast<PFNGLDELETEPROGRAMPROC>(loadProc("glDeleteProgram"));
    glDeleteRenderbuffersPointer =
        reinterpret_cast<PFNGLDELETERENDERBUFFERSPROC>(loadProc("glDeleteRenderbuffers"));
    glDeleteShaderPointer   = reinterpret_cast<PFNGLDELETESHADERPROC>(loadProc("glDeleteShader"));
    glDeleteTexturesPointer = reinterpret_cast<PFNGLDELETETEXTURESPROC>(loadProc("glDeleteTextures"));
    glDepthFuncPointer      = reinterpret_cast<PFNGLDEPTHFUNCPROC>(loadProc("glDepthFunc"));
    glDepthMaskPointer      = reinterpret_cast<PFNGLDEPTHMASKPROC>(loadProc("glDepthMask"));
    glDepthRangefPointer    = reinterpret_cast<PFNGLDEPTHRANGEFPROC>(loadProc("glDepthRangef"));
    glDetachShaderPointer   = reinterpret_cast<PFNGLDETACHSHADERPROC>(loadProc("glDetachShader"));
    glDisablePointer        = reinterpret_cast<PFNGLDISABLEPROC>(loadProc("glDisable"));
    glDisableVertexAttribArrayPointer =
        reinterpret_cast<PFNGLDISABLEVERTEXATTRIBARRAYPROC>(loadProc("glDisableVertexAttribArray"));
    glDrawArraysPointer   = reinterpret_cast<PFNGLDRAWARRAYSPROC>(loadProc("glDrawArrays"));
    glDrawElementsPointer = reinterpret_cast<PFNGLDRAWELEMENTSPROC>(loadProc("glDrawElements"));
    glEnablePointer       = reinterpret_cast<PFNGLENABLEPROC>(loadProc("glEnable"));
    glEnableVertexAttribArrayPointer =
        reinterpret_cast<PFNGLENABLEVERTEXATTRIBARRAYPROC>(loadProc("glEnableVertexAttribArray"));
    glFinishPointer = reinterpret_cast<PFNGLFINISHPROC>(loadProc("glFinish"));
    glFlushPointer  = reinterpret_cast<PFNGLFLUSHPROC>(loadProc("glFlush"));
    glFramebufferRenderbufferPointer =
        reinterpret_cast<PFNGLFRAMEBUFFERRENDERBUFFERPROC>(loadProc("glFramebufferRenderbuffer"));
    glFramebufferTexture2DPointer =
        reinterpret_cast<PFNGLFRAMEBUFFERTEXTURE2DPROC>(loadProc("glFramebufferTexture2D"));
    glFrontFacePointer       = reinterpret_cast<PFNGLFRONTFACEPROC>(loadProc("glFrontFace"));
    glGenBuffersPointer      = reinterpret_cast<PFNGLGENBUFFERSPROC>(loadProc("glGenBuffers"));
    glGenerateMipmapPointer  = reinterpret_cast<PFNGLGENERATEMIPMAPPROC>(loadProc("glGenerateMipmap"));
    glGenFramebuffersPointer = reinterpret_cast<PFNGLGENFRAMEBUFFERSPROC>(loadProc("glGenFramebuffers"));
    glGenRenderbuffersPointer =
        reinterpret_cast<PFNGLGENRENDERBUFFERSPROC>(loadProc("glGenRenderbuffers"));
    glGenTexturesPointer     = reinterpret_cast<PFNGLGENTEXTURESPROC>(loadProc("glGenTextures"));
    glGetActiveAttribPointer = reinterpret_cast<PFNGLGETACTIVEATTRIBPROC>(loadProc("glGetActiveAttrib"));
    glGetActiveUniformPointer =
        reinterpret_cast<PFNGLGETACTIVEUNIFORMPROC>(loadProc("glGetActiveUniform"));
    glGetAttachedShadersPointer =
        reinterpret_cast<PFNGLGETATTACHEDSHADERSPROC>(loadProc("glGetAttachedShaders"));
    glGetAttribLocationPointer =
        reinterpret_cast<PFNGLGETATTRIBLOCATIONPROC>(loadProc("glGetAttribLocation"));
    glGetBooleanvPointer = reinterpret_cast<PFNGLGETBOOLEANVPROC>(loadProc("glGetBooleanv"));
    glGetBufferParameterivPointer =
        reinterpret_cast<PFNGLGETBUFFERPARAMETERIVPROC>(loadProc("glGetBufferParameteriv"));
    glGetErrorPointer  = reinterpret_cast<PFNGLGETERRORPROC>(loadProc("glGetError"));
    glGetFloatvPointer = reinterpret_cast<PFNGLGETFLOATVPROC>(loadProc("glGetFloatv"));
    glGetFramebufferAttachmentParameterivPointer =
        reinterpret_cast<PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVPROC>(
            loadProc("glGetFramebufferAttachmentParameteriv"));
    glGetIntegervPointer  = reinterpret_cast<PFNGLGETINTEGERVPROC>(loadProc("glGetIntegerv"));
    glGetProgramivPointer = reinterpret_cast<PFNGLGETPROGRAMIVPROC>(loadProc("glGetProgramiv"));
    glGetProgramInfoLogPointer =
        reinterpret_cast<PFNGLGETPROGRAMINFOLOGPROC>(loadProc("glGetProgramInfoLog"));
    glGetRenderbufferParameterivPointer = reinterpret_cast<PFNGLGETRENDERBUFFERPARAMETERIVPROC>(
        loadProc("glGetRenderbufferParameteriv"));
    glGetShaderivPointer = reinterpret_cast<PFNGLGETSHADERIVPROC>(loadProc("glGetShaderiv"));
    glGetShaderInfoLogPointer =
        reinterpret_cast<PFNGLGETSHADERINFOLOGPROC>(loadProc("glGetShaderInfoLog"));
    glGetShaderPrecisionFormatPointer =
        reinterpret_cast<PFNGLGETSHADERPRECISIONFORMATPROC>(loadProc("glGetShaderPrecisionFormat"));
    glGetShaderSourcePointer = reinterpret_cast<PFNGLGETSHADERSOURCEPROC>(loadProc("glGetShaderSource"));
    glGetStringPointer       = reinterpret_cast<PFNGLGETSTRINGPROC>(loadProc("glGetString"));
    glGetTexParameterfvPointer =
        reinterpret_cast<PFNGLGETTEXPARAMETERFVPROC>(loadProc("glGetTexParameterfv"));
    glGetTexParameterivPointer =
        reinterpret_cast<PFNGLGETTEXPARAMETERIVPROC>(loadProc("glGetTexParameteriv"));
    glGetUniformfvPointer = reinterpret_cast<PFNGLGETUNIFORMFVPROC>(loadProc("glGetUniformfv"));
    glGetUniformivPointer = reinterpret_cast<PFNGLGETUNIFORMIVPROC>(loadProc("glGetUniformiv"));
    glGetUniformLocationPointer =
        reinterpret_cast<PFNGLGETUNIFORMLOCATIONPROC>(loadProc("glGetUniformLocation"));
    glGetVertexAttribfvPointer =
        reinterpret_cast<PFNGLGETVERTEXATTRIBFVPROC>(loadProc("glGetVertexAttribfv"));
    glGetVertexAttribivPointer =
        reinterpret_cast<PFNGLGETVERTEXATTRIBIVPROC>(loadProc("glGetVertexAttribiv"));
    glGetVertexAttribPointervPointer =
        reinterpret_cast<PFNGLGETVERTEXATTRIBPOINTERVPROC>(loadProc("glGetVertexAttribPointerv"));
    glHintPointer           = reinterpret_cast<PFNGLHINTPROC>(loadProc("glHint"));
    glIsBufferPointer       = reinterpret_cast<PFNGLISBUFFERPROC>(loadProc("glIsBuffer"));
    glIsEnabledPointer      = reinterpret_cast<PFNGLISENABLEDPROC>(loadProc("glIsEnabled"));
    glIsFramebufferPointer  = reinterpret_cast<PFNGLISFRAMEBUFFERPROC>(loadProc("glIsFramebuffer"));
    glIsProgramPointer      = reinterpret_cast<PFNGLISPROGRAMPROC>(loadProc("glIsProgram"));
    glIsRenderbufferPointer = reinterpret_cast<PFNGLISRENDERBUFFERPROC>(loadProc("glIsRenderbuffer"));
    glIsShaderPointer       = reinterpret_cast<PFNGLISSHADERPROC>(loadProc("glIsShader"));
    glIsTexturePointer      = reinterpret_cast<PFNGLISTEXTUREPROC>(loadProc("glIsTexture"));
    glLineWidthPointer      = reinterpret_cast<PFNGLLINEWIDTHPROC>(loadProc("glLineWidth"));
    glLinkProgramPointer    = reinterpret_cast<PFNGLLINKPROGRAMPROC>(loadProc("glLinkProgram"));
    glPixelStoreiPointer    = reinterpret_cast<PFNGLPIXELSTOREIPROC>(loadProc("glPixelStorei"));
    glPolygonOffsetPointer  = reinterpret_cast<PFNGLPOLYGONOFFSETPROC>(loadProc("glPolygonOffset"));
    glReadPixelsPointer     = reinterpret_cast<PFNGLREADPIXELSPROC>(loadProc("glReadPixels"));
    glReleaseShaderCompilerPointer =
        reinterpret_cast<PFNGLRELEASESHADERCOMPILERPROC>(loadProc("glReleaseShaderCompiler"));
    glRenderbufferStoragePointer =
        reinterpret_cast<PFNGLRENDERBUFFERSTORAGEPROC>(loadProc("glRenderbufferStorage"));
    glSampleCoveragePointer = reinterpret_cast<PFNGLSAMPLECOVERAGEPROC>(loadProc("glSampleCoverage"));
    glScissorPointer        = reinterpret_cast<PFNGLSCISSORPROC>(loadProc("glScissor"));
    glShaderBinaryPointer   = reinterpret_cast<PFNGLSHADERBINARYPROC>(loadProc("glShaderBinary"));
    glShaderSourcePointer   = reinterpret_cast<PFNGLSHADERSOURCEPROC>(loadProc("glShaderSource"));
    glStencilFuncPointer    = reinterpret_cast<PFNGLSTENCILFUNCPROC>(loadProc("glStencilFunc"));
    glStencilFuncSeparatePointer =
        reinterpret_cast<PFNGLSTENCILFUNCSEPARATEPROC>(loadProc("glStencilFuncSeparate"));
    glStencilMaskPointer = reinterpret_cast<PFNGLSTENCILMASKPROC>(loadProc("glStencilMask"));
    glStencilMaskSeparatePointer =
        reinterpret_cast<PFNGLSTENCILMASKSEPARATEPROC>(loadProc("glStencilMaskSeparate"));
    glStencilOpPointer = reinterpret_cast<PFNGLSTENCILOPPROC>(loadProc("glStencilOp"));
    glStencilOpSeparatePointer =
        reinterpret_cast<PFNGLSTENCILOPSEPARATEPROC>(loadProc("glStencilOpSeparate"));
    glTexImage2DPointer     = reinterpret_cast<PFNGLTEXIMAGE2DPROC>(loadProc("glTexImage2D"));
    glTexParameterfPointer  = reinterpret_cast<PFNGLTEXPARAMETERFPROC>(loadProc("glTexParameterf"));
    glTexParameterfvPointer = reinterpret_cast<PFNGLTEXPARAMETERFVPROC>(loadProc("glTexParameterfv"));
    glTexParameteriPointer  = reinterpret_cast<PFNGLTEXPARAMETERIPROC>(loadProc("glTexParameteri"));
    glTexParameterivPointer = reinterpret_cast<PFNGLTEXPARAMETERIVPROC>(loadProc("glTexParameteriv"));
    glTexSubImage2DPointer  = reinterpret_cast<PFNGLTEXSUBIMAGE2DPROC>(loadProc("glTexSubImage2D"));
    glUniform1fPointer      = reinterpret_cast<PFNGLUNIFORM1FPROC>(loadProc("glUniform1f"));
    glUniform1fvPointer     = reinterpret_cast<PFNGLUNIFORM1FVPROC>(loadProc("glUniform1fv"));
    glUniform1iPointer      = reinterpret_cast<PFNGLUNIFORM1IPROC>(loadProc("glUniform1i"));
    glUniform1ivPointer     = reinterpret_cast<PFNGLUNIFORM1IVPROC>(loadProc("glUniform1iv"));
    glUniform2fPointer      = reinterpret_cast<PFNGLUNIFORM2FPROC>(loadProc("glUniform2f"));
    glUniform2fvPointer     = reinterpret_cast<PFNGLUNIFORM2FVPROC>(loadProc("glUniform2fv"));
    glUniform2iPointer      = reinterpret_cast<PFNGLUNIFORM2IPROC>(loadProc("glUniform2i"));
    glUniform2ivPointer     = reinterpret_cast<PFNGLUNIFORM2IVPROC>(loadProc("glUniform2iv"));
    glUniform3fPointer      = reinterpret_cast<PFNGLUNIFORM3FPROC>(loadProc("glUniform3f"));
    glUniform3fvPointer     = reinterpret_cast<PFNGLUNIFORM3FVPROC>(loadProc("glUniform3fv"));
    glUniform3iPointer      = reinterpret_cast<PFNGLUNIFORM3IPROC>(loadProc("glUniform3i"));
    glUniform3ivPointer     = reinterpret_cast<PFNGLUNIFORM3IVPROC>(loadProc("glUniform3iv"));
    glUniform4fPointer      = reinterpret_cast<PFNGLUNIFORM4FPROC>(loadProc("glUniform4f"));
    glUniform4fvPointer     = reinterpret_cast<PFNGLUNIFORM4FVPROC>(loadProc("glUniform4fv"));
    glUniform4iPointer      = reinterpret_cast<PFNGLUNIFORM4IPROC>(loadProc("glUniform4i"));
    glUniform4ivPointer     = reinterpret_cast<PFNGLUNIFORM4IVPROC>(loadProc("glUniform4iv"));
    glUniformMatrix2fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX2FVPROC>(loadProc("glUniformMatrix2fv"));
    glUniformMatrix3fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX3FVPROC>(loadProc("glUniformMatrix3fv"));
    glUniformMatrix4fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX4FVPROC>(loadProc("glUniformMatrix4fv"));
    glUseProgramPointer      = reinterpret_cast<PFNGLUSEPROGRAMPROC>(loadProc("glUseProgram"));
    glValidateProgramPointer = reinterpret_cast<PFNGLVALIDATEPROGRAMPROC>(loadProc("glValidateProgram"));
    glVertexAttrib1fPointer  = reinterpret_cast<PFNGLVERTEXATTRIB1FPROC>(loadProc("glVertexAttrib1f"));
    glVertexAttrib1fvPointer = reinterpret_cast<PFNGLVERTEXATTRIB1FVPROC>(loadProc("glVertexAttrib1fv"));
    glVertexAttrib2fPointer  = reinterpret_cast<PFNGLVERTEXATTRIB2FPROC>(loadProc("glVertexAttrib2f"));
    glVertexAttrib2fvPointer = reinterpret_cast<PFNGLVERTEXATTRIB2FVPROC>(loadProc("glVertexAttrib2fv"));
    glVertexAttrib3fPointer  = reinterpret_cast<PFNGLVERTEXATTRIB3FPROC>(loadProc("glVertexAttrib3f"));
    glVertexAttrib3fvPointer = reinterpret_cast<PFNGLVERTEXATTRIB3FVPROC>(loadProc("glVertexAttrib3fv"));
    glVertexAttrib4fPointer  = reinterpret_cast<PFNGLVERTEXATTRIB4FPROC>(loadProc("glVertexAttrib4f"));
    glVertexAttrib4fvPointer = reinterpret_cast<PFNGLVERTEXATTRIB4FVPROC>(loadProc("glVertexAttrib4fv"));
    glVertexAttribPointerPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBPOINTERPROC>(loadProc("glVertexAttribPointer"));
    glViewportPointer   = reinterpret_cast<PFNGLVIEWPORTPROC>(loadProc("glViewport"));
    glReadBufferPointer = reinterpret_cast<PFNGLREADBUFFERPROC>(loadProc("glReadBuffer"));
    glDrawRangeElementsPointer =
        reinterpret_cast<PFNGLDRAWRANGEELEMENTSPROC>(loadProc("glDrawRangeElements"));
    glTexImage3DPointer    = reinterpret_cast<PFNGLTEXIMAGE3DPROC>(loadProc("glTexImage3D"));
    glTexSubImage3DPointer = reinterpret_cast<PFNGLTEXSUBIMAGE3DPROC>(loadProc("glTexSubImage3D"));
    glCopyTexSubImage3DPointer =
        reinterpret_cast<PFNGLCOPYTEXSUBIMAGE3DPROC>(loadProc("glCopyTexSubImage3D"));
    glCompressedTexImage3DPointer =
        reinterpret_cast<PFNGLCOMPRESSEDTEXIMAGE3DPROC>(loadProc("glCompressedTexImage3D"));
    glCompressedTexSubImage3DPointer =
        reinterpret_cast<PFNGLCOMPRESSEDTEXSUBIMAGE3DPROC>(loadProc("glCompressedTexSubImage3D"));
    glGenQueriesPointer    = reinterpret_cast<PFNGLGENQUERIESPROC>(loadProc("glGenQueries"));
    glDeleteQueriesPointer = reinterpret_cast<PFNGLDELETEQUERIESPROC>(loadProc("glDeleteQueries"));
    glIsQueryPointer       = reinterpret_cast<PFNGLISQUERYPROC>(loadProc("glIsQuery"));
    glBeginQueryPointer    = reinterpret_cast<PFNGLBEGINQUERYPROC>(loadProc("glBeginQuery"));
    glEndQueryPointer      = reinterpret_cast<PFNGLENDQUERYPROC>(loadProc("glEndQuery"));
    glGetQueryivPointer    = reinterpret_cast<PFNGLGETQUERYIVPROC>(loadProc("glGetQueryiv"));
    glGetQueryObjectuivPointer =
        reinterpret_cast<PFNGLGETQUERYOBJECTUIVPROC>(loadProc("glGetQueryObjectuiv"));
    glUnmapBufferPointer = reinterpret_cast<PFNGLUNMAPBUFFERPROC>(loadProc("glUnmapBuffer"));
    glGetBufferPointervPointer =
        reinterpret_cast<PFNGLGETBUFFERPOINTERVPROC>(loadProc("glGetBufferPointerv"));
    glDrawBuffersPointer = reinterpret_cast<PFNGLDRAWBUFFERSPROC>(loadProc("glDrawBuffers"));
    glUniformMatrix2x3fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX2X3FVPROC>(loadProc("glUniformMatrix2x3fv"));
    glUniformMatrix3x2fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX3X2FVPROC>(loadProc("glUniformMatrix3x2fv"));
    glUniformMatrix2x4fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX2X4FVPROC>(loadProc("glUniformMatrix2x4fv"));
    glUniformMatrix4x2fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX4X2FVPROC>(loadProc("glUniformMatrix4x2fv"));
    glUniformMatrix3x4fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX3X4FVPROC>(loadProc("glUniformMatrix3x4fv"));
    glUniformMatrix4x3fvPointer =
        reinterpret_cast<PFNGLUNIFORMMATRIX4X3FVPROC>(loadProc("glUniformMatrix4x3fv"));
    glBlitFramebufferPointer = reinterpret_cast<PFNGLBLITFRAMEBUFFERPROC>(loadProc("glBlitFramebuffer"));
    glRenderbufferStorageMultisamplePointer = reinterpret_cast<PFNGLRENDERBUFFERSTORAGEMULTISAMPLEPROC>(
        loadProc("glRenderbufferStorageMultisample"));
    glFramebufferTextureLayerPointer =
        reinterpret_cast<PFNGLFRAMEBUFFERTEXTURELAYERPROC>(loadProc("glFramebufferTextureLayer"));
    glMapBufferRangePointer = reinterpret_cast<PFNGLMAPBUFFERRANGEPROC>(loadProc("glMapBufferRange"));
    glFlushMappedBufferRangePointer =
        reinterpret_cast<PFNGLFLUSHMAPPEDBUFFERRANGEPROC>(loadProc("glFlushMappedBufferRange"));
    glBindVertexArrayPointer = reinterpret_cast<PFNGLBINDVERTEXARRAYPROC>(loadProc("glBindVertexArray"));
    glDeleteVertexArraysPointer =
        reinterpret_cast<PFNGLDELETEVERTEXARRAYSPROC>(loadProc("glDeleteVertexArrays"));
    glGenVertexArraysPointer = reinterpret_cast<PFNGLGENVERTEXARRAYSPROC>(loadProc("glGenVertexArrays"));
    glIsVertexArrayPointer   = reinterpret_cast<PFNGLISVERTEXARRAYPROC>(loadProc("glIsVertexArray"));
    glGetIntegeri_vPointer   = reinterpret_cast<PFNGLGETINTEGERI_VPROC>(loadProc("glGetIntegeri_v"));
    glBeginTransformFeedbackPointer =
        reinterpret_cast<PFNGLBEGINTRANSFORMFEEDBACKPROC>(loadProc("glBeginTransformFeedback"));
    glEndTransformFeedbackPointer =
        reinterpret_cast<PFNGLENDTRANSFORMFEEDBACKPROC>(loadProc("glEndTransformFeedback"));
    glBindBufferRangePointer = reinterpret_cast<PFNGLBINDBUFFERRANGEPROC>(loadProc("glBindBufferRange"));
    glBindBufferBasePointer  = reinterpret_cast<PFNGLBINDBUFFERBASEPROC>(loadProc("glBindBufferBase"));
    glTransformFeedbackVaryingsPointer = reinterpret_cast<PFNGLTRANSFORMFEEDBACKVARYINGSPROC>(
        loadProc("glTransformFeedbackVaryings"));
    glGetTransformFeedbackVaryingPointer = reinterpret_cast<PFNGLGETTRANSFORMFEEDBACKVARYINGPROC>(
        loadProc("glGetTransformFeedbackVarying"));
    glVertexAttribIPointerPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBIPOINTERPROC>(loadProc("glVertexAttribIPointer"));
    glGetVertexAttribIivPointer =
        reinterpret_cast<PFNGLGETVERTEXATTRIBIIVPROC>(loadProc("glGetVertexAttribIiv"));
    glGetVertexAttribIuivPointer =
        reinterpret_cast<PFNGLGETVERTEXATTRIBIUIVPROC>(loadProc("glGetVertexAttribIuiv"));
    glVertexAttribI4iPointer = reinterpret_cast<PFNGLVERTEXATTRIBI4IPROC>(loadProc("glVertexAttribI4i"));
    glVertexAttribI4uiPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBI4UIPROC>(loadProc("glVertexAttribI4ui"));
    glVertexAttribI4ivPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBI4IVPROC>(loadProc("glVertexAttribI4iv"));
    glVertexAttribI4uivPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBI4UIVPROC>(loadProc("glVertexAttribI4uiv"));
    glGetUniformuivPointer = reinterpret_cast<PFNGLGETUNIFORMUIVPROC>(loadProc("glGetUniformuiv"));
    glGetFragDataLocationPointer =
        reinterpret_cast<PFNGLGETFRAGDATALOCATIONPROC>(loadProc("glGetFragDataLocation"));
    glUniform1uiPointer     = reinterpret_cast<PFNGLUNIFORM1UIPROC>(loadProc("glUniform1ui"));
    glUniform2uiPointer     = reinterpret_cast<PFNGLUNIFORM2UIPROC>(loadProc("glUniform2ui"));
    glUniform3uiPointer     = reinterpret_cast<PFNGLUNIFORM3UIPROC>(loadProc("glUniform3ui"));
    glUniform4uiPointer     = reinterpret_cast<PFNGLUNIFORM4UIPROC>(loadProc("glUniform4ui"));
    glUniform1uivPointer    = reinterpret_cast<PFNGLUNIFORM1UIVPROC>(loadProc("glUniform1uiv"));
    glUniform2uivPointer    = reinterpret_cast<PFNGLUNIFORM2UIVPROC>(loadProc("glUniform2uiv"));
    glUniform3uivPointer    = reinterpret_cast<PFNGLUNIFORM3UIVPROC>(loadProc("glUniform3uiv"));
    glUniform4uivPointer    = reinterpret_cast<PFNGLUNIFORM4UIVPROC>(loadProc("glUniform4uiv"));
    glClearBufferivPointer  = reinterpret_cast<PFNGLCLEARBUFFERIVPROC>(loadProc("glClearBufferiv"));
    glClearBufferuivPointer = reinterpret_cast<PFNGLCLEARBUFFERUIVPROC>(loadProc("glClearBufferuiv"));
    glClearBufferfvPointer  = reinterpret_cast<PFNGLCLEARBUFFERFVPROC>(loadProc("glClearBufferfv"));
    glClearBufferfiPointer  = reinterpret_cast<PFNGLCLEARBUFFERFIPROC>(loadProc("glClearBufferfi"));
    glGetStringiPointer     = reinterpret_cast<PFNGLGETSTRINGIPROC>(loadProc("glGetStringi"));
    glCopyBufferSubDataPointer =
        reinterpret_cast<PFNGLCOPYBUFFERSUBDATAPROC>(loadProc("glCopyBufferSubData"));
    glGetUniformIndicesPointer =
        reinterpret_cast<PFNGLGETUNIFORMINDICESPROC>(loadProc("glGetUniformIndices"));
    glGetActiveUniformsivPointer =
        reinterpret_cast<PFNGLGETACTIVEUNIFORMSIVPROC>(loadProc("glGetActiveUniformsiv"));
    glGetUniformBlockIndexPointer =
        reinterpret_cast<PFNGLGETUNIFORMBLOCKINDEXPROC>(loadProc("glGetUniformBlockIndex"));
    glGetActiveUniformBlockivPointer =
        reinterpret_cast<PFNGLGETACTIVEUNIFORMBLOCKIVPROC>(loadProc("glGetActiveUniformBlockiv"));
    glGetActiveUniformBlockNamePointer = reinterpret_cast<PFNGLGETACTIVEUNIFORMBLOCKNAMEPROC>(
        loadProc("glGetActiveUniformBlockName"));
    glUniformBlockBindingPointer =
        reinterpret_cast<PFNGLUNIFORMBLOCKBINDINGPROC>(loadProc("glUniformBlockBinding"));
    glDrawArraysInstancedPointer =
        reinterpret_cast<PFNGLDRAWARRAYSINSTANCEDPROC>(loadProc("glDrawArraysInstanced"));
    glDrawElementsInstancedPointer =
        reinterpret_cast<PFNGLDRAWELEMENTSINSTANCEDPROC>(loadProc("glDrawElementsInstanced"));
    glFenceSyncPointer       = reinterpret_cast<PFNGLFENCESYNCPROC>(loadProc("glFenceSync"));
    glIsSyncPointer          = reinterpret_cast<PFNGLISSYNCPROC>(loadProc("glIsSync"));
    glDeleteSyncPointer      = reinterpret_cast<PFNGLDELETESYNCPROC>(loadProc("glDeleteSync"));
    glClientWaitSyncPointer  = reinterpret_cast<PFNGLCLIENTWAITSYNCPROC>(loadProc("glClientWaitSync"));
    glWaitSyncPointer        = reinterpret_cast<PFNGLWAITSYNCPROC>(loadProc("glWaitSync"));
    glGetInteger64vPointer   = reinterpret_cast<PFNGLGETINTEGER64VPROC>(loadProc("glGetInteger64v"));
    glGetSyncivPointer       = reinterpret_cast<PFNGLGETSYNCIVPROC>(loadProc("glGetSynciv"));
    glGetInteger64i_vPointer = reinterpret_cast<PFNGLGETINTEGER64I_VPROC>(loadProc("glGetInteger64i_v"));
    glGetBufferParameteri64vPointer =
        reinterpret_cast<PFNGLGETBUFFERPARAMETERI64VPROC>(loadProc("glGetBufferParameteri64v"));
    glGenSamplersPointer    = reinterpret_cast<PFNGLGENSAMPLERSPROC>(loadProc("glGenSamplers"));
    glDeleteSamplersPointer = reinterpret_cast<PFNGLDELETESAMPLERSPROC>(loadProc("glDeleteSamplers"));
    glIsSamplerPointer      = reinterpret_cast<PFNGLISSAMPLERPROC>(loadProc("glIsSampler"));
    glBindSamplerPointer    = reinterpret_cast<PFNGLBINDSAMPLERPROC>(loadProc("glBindSampler"));
    glSamplerParameteriPointer =
        reinterpret_cast<PFNGLSAMPLERPARAMETERIPROC>(loadProc("glSamplerParameteri"));
    glSamplerParameterivPointer =
        reinterpret_cast<PFNGLSAMPLERPARAMETERIVPROC>(loadProc("glSamplerParameteriv"));
    glSamplerParameterfPointer =
        reinterpret_cast<PFNGLSAMPLERPARAMETERFPROC>(loadProc("glSamplerParameterf"));
    glSamplerParameterfvPointer =
        reinterpret_cast<PFNGLSAMPLERPARAMETERFVPROC>(loadProc("glSamplerParameterfv"));
    glGetSamplerParameterivPointer =
        reinterpret_cast<PFNGLGETSAMPLERPARAMETERIVPROC>(loadProc("glGetSamplerParameteriv"));
    glGetSamplerParameterfvPointer =
        reinterpret_cast<PFNGLGETSAMPLERPARAMETERFVPROC>(loadProc("glGetSamplerParameterfv"));
    glVertexAttribDivisorPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBDIVISORPROC>(loadProc("glVertexAttribDivisor"));
    glBindTransformFeedbackPointer =
        reinterpret_cast<PFNGLBINDTRANSFORMFEEDBACKPROC>(loadProc("glBindTransformFeedback"));
    glDeleteTransformFeedbacksPointer =
        reinterpret_cast<PFNGLDELETETRANSFORMFEEDBACKSPROC>(loadProc("glDeleteTransformFeedbacks"));
    glGenTransformFeedbacksPointer =
        reinterpret_cast<PFNGLGENTRANSFORMFEEDBACKSPROC>(loadProc("glGenTransformFeedbacks"));
    glIsTransformFeedbackPointer =
        reinterpret_cast<PFNGLISTRANSFORMFEEDBACKPROC>(loadProc("glIsTransformFeedback"));
    glPauseTransformFeedbackPointer =
        reinterpret_cast<PFNGLPAUSETRANSFORMFEEDBACKPROC>(loadProc("glPauseTransformFeedback"));
    glResumeTransformFeedbackPointer =
        reinterpret_cast<PFNGLRESUMETRANSFORMFEEDBACKPROC>(loadProc("glResumeTransformFeedback"));
    glGetProgramBinaryPointer =
        reinterpret_cast<PFNGLGETPROGRAMBINARYPROC>(loadProc("glGetProgramBinary"));
    glProgramBinaryPointer = reinterpret_cast<PFNGLPROGRAMBINARYPROC>(loadProc("glProgramBinary"));
    glProgramParameteriPointer =
        reinterpret_cast<PFNGLPROGRAMPARAMETERIPROC>(loadProc("glProgramParameteri"));
    glInvalidateFramebufferPointer =
        reinterpret_cast<PFNGLINVALIDATEFRAMEBUFFERPROC>(loadProc("glInvalidateFramebuffer"));
    glInvalidateSubFramebufferPointer =
        reinterpret_cast<PFNGLINVALIDATESUBFRAMEBUFFERPROC>(loadProc("glInvalidateSubFramebuffer"));
    glTexStorage2DPointer = reinterpret_cast<PFNGLTEXSTORAGE2DPROC>(loadProc("glTexStorage2D"));
    glTexStorage3DPointer = reinterpret_cast<PFNGLTEXSTORAGE3DPROC>(loadProc("glTexStorage3D"));
    glGetInternalformativPointer =
        reinterpret_cast<PFNGLGETINTERNALFORMATIVPROC>(loadProc("glGetInternalformativ"));
    glDispatchComputePointer = reinterpret_cast<PFNGLDISPATCHCOMPUTEPROC>(loadProc("glDispatchCompute"));
    glDispatchComputeIndirectPointer =
        reinterpret_cast<PFNGLDISPATCHCOMPUTEINDIRECTPROC>(loadProc("glDispatchComputeIndirect"));
    glDrawArraysIndirectPointer =
        reinterpret_cast<PFNGLDRAWARRAYSINDIRECTPROC>(loadProc("glDrawArraysIndirect"));
    glDrawElementsIndirectPointer =
        reinterpret_cast<PFNGLDRAWELEMENTSINDIRECTPROC>(loadProc("glDrawElementsIndirect"));
    glFramebufferParameteriPointer =
        reinterpret_cast<PFNGLFRAMEBUFFERPARAMETERIPROC>(loadProc("glFramebufferParameteri"));
    glGetFramebufferParameterivPointer = reinterpret_cast<PFNGLGETFRAMEBUFFERPARAMETERIVPROC>(
        loadProc("glGetFramebufferParameteriv"));
    glGetProgramInterfaceivPointer =
        reinterpret_cast<PFNGLGETPROGRAMINTERFACEIVPROC>(loadProc("glGetProgramInterfaceiv"));
    glGetProgramResourceIndexPointer =
        reinterpret_cast<PFNGLGETPROGRAMRESOURCEINDEXPROC>(loadProc("glGetProgramResourceIndex"));
    glGetProgramResourceNamePointer =
        reinterpret_cast<PFNGLGETPROGRAMRESOURCENAMEPROC>(loadProc("glGetProgramResourceName"));
    glGetProgramResourceivPointer =
        reinterpret_cast<PFNGLGETPROGRAMRESOURCEIVPROC>(loadProc("glGetProgramResourceiv"));
    glGetProgramResourceLocationPointer = reinterpret_cast<PFNGLGETPROGRAMRESOURCELOCATIONPROC>(
        loadProc("glGetProgramResourceLocation"));
    glUseProgramStagesPointer =
        reinterpret_cast<PFNGLUSEPROGRAMSTAGESPROC>(loadProc("glUseProgramStages"));
    glActiveShaderProgramPointer =
        reinterpret_cast<PFNGLACTIVESHADERPROGRAMPROC>(loadProc("glActiveShaderProgram"));
    glCreateShaderProgramvPointer =
        reinterpret_cast<PFNGLCREATESHADERPROGRAMVPROC>(loadProc("glCreateShaderProgramv"));
    glBindProgramPipelinePointer =
        reinterpret_cast<PFNGLBINDPROGRAMPIPELINEPROC>(loadProc("glBindProgramPipeline"));
    glDeleteProgramPipelinesPointer =
        reinterpret_cast<PFNGLDELETEPROGRAMPIPELINESPROC>(loadProc("glDeleteProgramPipelines"));
    glGenProgramPipelinesPointer =
        reinterpret_cast<PFNGLGENPROGRAMPIPELINESPROC>(loadProc("glGenProgramPipelines"));
    glIsProgramPipelinePointer =
        reinterpret_cast<PFNGLISPROGRAMPIPELINEPROC>(loadProc("glIsProgramPipeline"));
    glGetProgramPipelineivPointer =
        reinterpret_cast<PFNGLGETPROGRAMPIPELINEIVPROC>(loadProc("glGetProgramPipelineiv"));
    glProgramUniform1iPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM1IPROC>(loadProc("glProgramUniform1i"));
    glProgramUniform2iPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM2IPROC>(loadProc("glProgramUniform2i"));
    glProgramUniform3iPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM3IPROC>(loadProc("glProgramUniform3i"));
    glProgramUniform4iPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM4IPROC>(loadProc("glProgramUniform4i"));
    glProgramUniform1uiPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM1UIPROC>(loadProc("glProgramUniform1ui"));
    glProgramUniform2uiPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM2UIPROC>(loadProc("glProgramUniform2ui"));
    glProgramUniform3uiPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM3UIPROC>(loadProc("glProgramUniform3ui"));
    glProgramUniform4uiPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM4UIPROC>(loadProc("glProgramUniform4ui"));
    glProgramUniform1fPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM1FPROC>(loadProc("glProgramUniform1f"));
    glProgramUniform2fPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM2FPROC>(loadProc("glProgramUniform2f"));
    glProgramUniform3fPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM3FPROC>(loadProc("glProgramUniform3f"));
    glProgramUniform4fPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM4FPROC>(loadProc("glProgramUniform4f"));
    glProgramUniform1ivPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM1IVPROC>(loadProc("glProgramUniform1iv"));
    glProgramUniform2ivPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM2IVPROC>(loadProc("glProgramUniform2iv"));
    glProgramUniform3ivPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM3IVPROC>(loadProc("glProgramUniform3iv"));
    glProgramUniform4ivPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM4IVPROC>(loadProc("glProgramUniform4iv"));
    glProgramUniform1uivPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM1UIVPROC>(loadProc("glProgramUniform1uiv"));
    glProgramUniform2uivPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM2UIVPROC>(loadProc("glProgramUniform2uiv"));
    glProgramUniform3uivPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM3UIVPROC>(loadProc("glProgramUniform3uiv"));
    glProgramUniform4uivPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM4UIVPROC>(loadProc("glProgramUniform4uiv"));
    glProgramUniform1fvPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM1FVPROC>(loadProc("glProgramUniform1fv"));
    glProgramUniform2fvPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM2FVPROC>(loadProc("glProgramUniform2fv"));
    glProgramUniform3fvPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM3FVPROC>(loadProc("glProgramUniform3fv"));
    glProgramUniform4fvPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORM4FVPROC>(loadProc("glProgramUniform4fv"));
    glProgramUniformMatrix2fvPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX2FVPROC>(loadProc("glProgramUniformMatrix2fv"));
    glProgramUniformMatrix3fvPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX3FVPROC>(loadProc("glProgramUniformMatrix3fv"));
    glProgramUniformMatrix4fvPointer =
        reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX4FVPROC>(loadProc("glProgramUniformMatrix4fv"));
    glProgramUniformMatrix2x3fvPointer = reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX2X3FVPROC>(
        loadProc("glProgramUniformMatrix2x3fv"));
    glProgramUniformMatrix3x2fvPointer = reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX3X2FVPROC>(
        loadProc("glProgramUniformMatrix3x2fv"));
    glProgramUniformMatrix2x4fvPointer = reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX2X4FVPROC>(
        loadProc("glProgramUniformMatrix2x4fv"));
    glProgramUniformMatrix4x2fvPointer = reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX4X2FVPROC>(
        loadProc("glProgramUniformMatrix4x2fv"));
    glProgramUniformMatrix3x4fvPointer = reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX3X4FVPROC>(
        loadProc("glProgramUniformMatrix3x4fv"));
    glProgramUniformMatrix4x3fvPointer = reinterpret_cast<PFNGLPROGRAMUNIFORMMATRIX4X3FVPROC>(
        loadProc("glProgramUniformMatrix4x3fv"));
    glValidateProgramPipelinePointer =
        reinterpret_cast<PFNGLVALIDATEPROGRAMPIPELINEPROC>(loadProc("glValidateProgramPipeline"));
    glGetProgramPipelineInfoLogPointer = reinterpret_cast<PFNGLGETPROGRAMPIPELINEINFOLOGPROC>(
        loadProc("glGetProgramPipelineInfoLog"));
    glBindImageTexturePointer =
        reinterpret_cast<PFNGLBINDIMAGETEXTUREPROC>(loadProc("glBindImageTexture"));
    glGetBooleani_vPointer = reinterpret_cast<PFNGLGETBOOLEANI_VPROC>(loadProc("glGetBooleani_v"));
    glMemoryBarrierPointer = reinterpret_cast<PFNGLMEMORYBARRIERPROC>(loadProc("glMemoryBarrier"));
    glMemoryBarrierByRegionPointer =
        reinterpret_cast<PFNGLMEMORYBARRIERBYREGIONPROC>(loadProc("glMemoryBarrierByRegion"));
    glTexStorage2DMultisamplePointer =
        reinterpret_cast<PFNGLTEXSTORAGE2DMULTISAMPLEPROC>(loadProc("glTexStorage2DMultisample"));
    glGetMultisamplefvPointer =
        reinterpret_cast<PFNGLGETMULTISAMPLEFVPROC>(loadProc("glGetMultisamplefv"));
    glSampleMaskiPointer = reinterpret_cast<PFNGLSAMPLEMASKIPROC>(loadProc("glSampleMaski"));
    glGetTexLevelParameterivPointer =
        reinterpret_cast<PFNGLGETTEXLEVELPARAMETERIVPROC>(loadProc("glGetTexLevelParameteriv"));
    glGetTexLevelParameterfvPointer =
        reinterpret_cast<PFNGLGETTEXLEVELPARAMETERFVPROC>(loadProc("glGetTexLevelParameterfv"));
    glBindVertexBufferPointer =
        reinterpret_cast<PFNGLBINDVERTEXBUFFERPROC>(loadProc("glBindVertexBuffer"));
    glVertexAttribFormatPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBFORMATPROC>(loadProc("glVertexAttribFormat"));
    glVertexAttribIFormatPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBIFORMATPROC>(loadProc("glVertexAttribIFormat"));
    glVertexAttribBindingPointer =
        reinterpret_cast<PFNGLVERTEXATTRIBBINDINGPROC>(loadProc("glVertexAttribBinding"));
    glVertexBindingDivisorPointer =
        reinterpret_cast<PFNGLVERTEXBINDINGDIVISORPROC>(loadProc("glVertexBindingDivisor"));
    
    glBindFramebufferOESPointer =
        reinterpret_cast<PFNGLBINDFRAMEBUFFEROESPROC>(loadProc("glBindFramebufferOES"));
    glBindRenderbufferOESPointer =
        reinterpret_cast<PFNGLBINDRENDERBUFFEROESPROC>(loadProc("glBindRenderbufferOES"));
    glCheckFramebufferStatusOESPointer = reinterpret_cast<PFNGLCHECKFRAMEBUFFERSTATUSOESPROC>(
        loadProc("glCheckFramebufferStatusOES"));
    glDeleteFramebuffersOESPointer =
        reinterpret_cast<PFNGLDELETEFRAMEBUFFERSOESPROC>(loadProc("glDeleteFramebuffersOES"));
    glDeleteRenderbuffersOESPointer =
        reinterpret_cast<PFNGLDELETERENDERBUFFERSOESPROC>(loadProc("glDeleteRenderbuffersOES"));
    glFramebufferRenderbufferOESPointer = reinterpret_cast<PFNGLFRAMEBUFFERRENDERBUFFEROESPROC>(
        loadProc("glFramebufferRenderbufferOES"));
    glFramebufferTexture2DOESPointer =
        reinterpret_cast<PFNGLFRAMEBUFFERTEXTURE2DOESPROC>(loadProc("glFramebufferTexture2DOES"));
    glGenFramebuffersOESPointer =
        reinterpret_cast<PFNGLGENFRAMEBUFFERSOESPROC>(loadProc("glGenFramebuffersOES"));
    glGenRenderbuffersOESPointer =
        reinterpret_cast<PFNGLGENRENDERBUFFERSOESPROC>(loadProc("glGenRenderbuffersOES"));
    glGenerateMipmapOESPointer =
        reinterpret_cast<PFNGLGENERATEMIPMAPOESPROC>(loadProc("glGenerateMipmapOES"));
    glGetFramebufferAttachmentParameterivOESPointer =
        reinterpret_cast<PFNGLGETFRAMEBUFFERATTACHMENTPARAMETERIVOESPROC>(
            loadProc("glGetFramebufferAttachmentParameterivOES"));
    glGetRenderbufferParameterivOESPointer = reinterpret_cast<PFNGLGETRENDERBUFFERPARAMETERIVOESPROC>(
        loadProc("glGetRenderbufferParameterivOES"));
    glIsFramebufferOESPointer =
        reinterpret_cast<PFNGLISFRAMEBUFFEROESPROC>(loadProc("glIsFramebufferOES"));
    glIsRenderbufferOESPointer =
        reinterpret_cast<PFNGLISRENDERBUFFEROESPROC>(loadProc("glIsRenderbufferOES"));
    glRenderbufferStorageOESPointer =
        reinterpret_cast<PFNGLRENDERBUFFERSTORAGEOESPROC>(loadProc("glRenderbufferStorageOES"));

    glBlendFuncSeparateOESPointer =
        reinterpret_cast<PFNGLBLENDFUNCSEPARATEPROC>(loadProc("glBlendFuncSeparateOES"));
    glBlendEquationOESPointer = reinterpret_cast<PFNGLBLENDEQUATIONPROC>(loadProc("glBlendEquationOES"));
}

}
}
}

#endif
