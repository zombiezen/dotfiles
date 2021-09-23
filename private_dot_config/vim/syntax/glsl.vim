" GLSL syntax file

" Quit when a (custom) syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

syn case match

" Keywords
syn keyword glslStructDecl      struct
syn keyword glslStorageClass    const in out inout attribute uniform varying centroid sample patch
syn keyword glslInterpolation   smooth flat noperspective
syn keyword glslPrecision       precise highp mediump lowp
syn keyword glslInvariant       invariant
syn keyword glslMemory          coherent volatile restrict readonly writeonly
syn keyword glslBoolean         true false

syn keyword glslType            void bool int uint float double atomic_uint
syn keyword glslType            vec2 vec3 vec4 dvec2 dvec3 dvec4 bvec2 bvec3 bvec4 ivec2 ivec3 ivec4 uvec2 uvec3 uvec4 
syn keyword glslType            mat2 mat3 mat4 mat2x2 mat2x3 mat2x4 mat3x2 mat3x3 mat3x4 mat4x2 mat4x3 mat4x4
syn keyword glslType            dmat2 dmat3 dmat4 dmat2x2 dmat2x3 dmat2x4 dmat3x2 dmat3x3 dmat3x4 dmat4x2 dmat4x3 dmat4x4
syn keyword glslType            sampler1D sampler2D sampler3D samplerCube 
syn keyword glslType            sampler1DShadow sampler2DShadow samplerCubeShadow
syn keyword glslType            sampler1DArray sampler2DArray
syn keyword glslType            sampler1DArrayShadow sampler2DArrayShadow
syn keyword glslType            isampler1D isampler2D isampler3D isamplerCube
syn keyword glslType            isampler1DArray isampler2DArray
syn keyword glslType            usampler1D usampler2D usampler3D usamplerCube
syn keyword glslType            usampler1DArray usampler2DArray
syn keyword glslType            sampler2DRect sampler2DRectShadow isampler2DRect usampler2DRect
syn keyword glslType            samplerBuffer isamplerBuffer usamplerBuffer
syn keyword glslType            sampler2DMS isampler2DMS usampler2DMS
syn keyword glslType            sampler2DMSArray isampler2DMSArray usampler2DMSArray
syn keyword glslType            samplerCubeArray samplerCubeArrayShadow isamplerCubeArray usamplerCubeArray
syn keyword glslType            image1D iimage1D uimage1D
syn keyword glslType            image2D iimage2D uimage2D
syn keyword glslType            image3D iimage3D uimage3D
syn keyword glslType            image2DRect iimage2DRect uimage2DRect
syn keyword glslType            imageCube iimageCube uimageCube
syn keyword glslType            imageBuffer iimageBuffer uimageBuffer
syn keyword glslType            image1DArray iimage1DArray uimage1DArray
syn keyword glslType            image2DArray iimage2DArray uimage2DArray
syn keyword glslType            imageCubeArray iimageCubeArray uimageCubeArray
syn keyword glslType            image2DMS iimage2DMS uimage2DMS
syn keyword glslType            image2DMSArray iimage2DMSArray uimage2DMSArray

" Reserved words
syn keyword glslReserved        common partition active asm
syn keyword glslReserved        class union enum typedef template this packed resource
syn keyword glslReserved        goto inline noinline public static extern external interface
syn keyword glslReserved        long short half fixed unsigned superp
syn keyword glslReserved        input output hvec2 hvec3 hvec4 fvec2 fvec3 fvec4
syn keyword glslReserved        sampler3DRect filter sizeof cast namespace using row_major

" Layout
syn region  glslLayout          start="\<layout\s*(" end=")"    contains=glslLayoutName,glslInteger
syn keyword glslLayoutName      location index offset           contained
syn keyword glslLayoutName      triangles quads isolines equal_spacing fractional_even_spacing fractional_odd_spacing cw ccw point_mode vertices  contained
syn keyword glslLayoutName      points lines lines_adjacency triangles triangles_adjacency invocations line_strip triangle_strip max_vertices stream contained
syn keyword glslLayoutName      origin_upper_left pixel_center_integer early_fragment_tests depth_any depth_greater depth_less depth_unchanged   contained
syn keyword glslLayoutName      origin_upper_left pixel_center_integer early_fragment_tests depth_any depth_greater depth_less depth_unchanged   contained
syn keyword glslLayoutName      shared packed std140 row_major column_major binding contained
syn keyword glslLayoutName      rgba32f rgba16f rg32f rg16f r11f_g11f_b10f r32f r16f rgba16 rgb10_a2 rgba8 rg16 rg8 r16 r8 rgba16_snorm rgba8_snorm rg16_snorm rg8_snorm r16_snorm r8_snorm contained
syn keyword glslLayoutName      rgba32i rgba16i rgba8i rg32i rg16i rg8i r32i r16i r8i contained
syn keyword glslLayoutName      rgba32ui rgba16ui rgb10_a2ui rgba8ui rg32ui rg16ui rg8ui r32ui r16ui r8ui contained

" Literals
syn match   glslInteger         "\<\(0[0-7]*\|0[xX]\x\+\|\d\+\)[uU]\=\>"
syn match   glslFloat           "\<\(\d\+\.\d\+\|\d\+\.\|\.\d\+\)\([eE][-+]\=\d\+\)\=\([fF]\|lf\|LF\)\=\>"
syn match   glslFloat           "\<\d\+\([eE][-+]\=\d\+\)\([fF]\|lf\|LF\)\=\>"

" Statements
syn keyword glslConditional     if else switch
syn keyword glslRepeat          for while do
syn keyword glslLabel           case default
syn keyword glslStatement       discard return break continue precision

" Operators
" TODO: Fix boundaries
syn match   glslOperator        "\(++\|--\|<<\|>>\|<=\|>=\|==\|!=\|&&\|^^\|||\|+=\|-=\|*=\|/=\|%=\|<<=\|>>=\|&=\|^=\||=\|[-.+~!*/%<>&^|?:=]\)"

" Built-in Variables
syn keyword glslBuiltIn         gl_VertexID gl_InstanceID
syn keyword glslBuiltIn         gl_PerVertex gl_Position gl_PointSize gl_ClipDistance
syn keyword glslBuiltIn         gl_in gl_PrimitiveID gl_PrimitiveIDIn gl_InvocationID
syn keyword glslBuiltIn         gl_Layer gl_ViewportIndex
syn keyword glslBuiltIn         gl_PatchVerticesIn gl_TessLevelOuter gl_TessLevelInner gl_TessCoord
syn keyword glslBuiltIn         gl_FragCoord gl_FrontFacing gl_PointCoord
syn keyword glslBuiltIn         gl_SampleID gl_SamplePosition gl_SampleMaskIn gl_SampleMask gl_FragDepth
syn keyword glslBuiltIn         gl_DepthRange

" Built-in Constants
syn keyword glslBuiltIn         gl_MaxVertexAttribs gl_MaxVertexUniformComponents
syn keyword glslBuiltIn         gl_MaxVaryingComponents gl_MaxVertexOutputComponents
syn keyword glslBuiltIn         gl_MaxGeometryInputComponents gl_MaxGeometryOutputComponents
syn keyword glslBuiltIn         gl_MaxFragmentInputComponents gl_MaxVertexTextureImageUnits
syn keyword glslBuiltIn         gl_MaxCombinedTextureImageUnits gl_MaxTextureImageUnits
syn keyword glslBuiltIn         gl_MaxImageUnits gl_MaxCombinedImageUnitsAndFragmentOutputs
syn keyword glslBuiltIn         gl_MaxImageSamples gl_MaxVertexImageUniforms
syn keyword glslBuiltIn         gl_MaxTessControlImageUniforms gl_MaxTessEvaluationImageUniforms
syn keyword glslBuiltIn         gl_MaxGeometryImageUniforms gl_MaxFragmentImageUniforms
syn keyword glslBuiltIn         gl_MaxCombinedImageUniforms gl_MaxFragmentUniformComponents
syn keyword glslBuiltIn         gl_MaxDrawBuffers gl_MaxClipDistances
syn keyword glslBuiltIn         gl_MaxGeometryTextureImageUnits gl_MaxGeometryOutputVertices
syn keyword glslBuiltIn         gl_MaxGeometryTotalOutputComponents gl_MaxGeometryUniformComponents
syn keyword glslBuiltIn         gl_MaxGeometryVaryingComponents gl_MaxTessControlInputComponents
syn keyword glslBuiltIn         gl_MaxTessControlOutputComponents gl_MaxTessControlTextureImageUnits
syn keyword glslBuiltIn         gl_MaxTessControlUniformComponents
syn keyword glslBuiltIn         gl_MaxTessControlTotalOutputComponents
syn keyword glslBuiltIn         gl_MaxTessEvaluationInputComponents
syn keyword glslBuiltIn         gl_MaxTessEvaluationOutputComponents
syn keyword glslBuiltIn         gl_MaxTessEvaluationTextureImageUnits
syn keyword glslBuiltIn         gl_MaxTessEvaluationUniformComponents
syn keyword glslBuiltIn         gl_MaxTessPatchComponents gl_MaxPatchVertices gl_MaxTessGenLevel
syn keyword glslBuiltIn         gl_MaxViewports gl_MaxVertexUniformVectors
syn keyword glslBuiltIn         gl_MaxFragmentUniformVectors gl_MaxVaryingVectors
syn keyword glslBuiltIn         gl_MaxVertexAtomicCounters gl_MaxTessControlAtomicCounters
syn keyword glslBuiltIn         gl_MaxTessEvaluationAtomicCounters gl_MaxGeometryAtomicCounters
syn keyword glslBuiltIn         gl_MaxFragmentAtomicCounters gl_MaxCombinedAtomicCounters
syn keyword glslBuiltIn         gl_MaxAtomicCounterBindings gl_MaxVertexAtomicCounterBuffers
syn keyword glslBuiltIn         gl_MaxTessControlAtomicCounterBuffers
syn keyword glslBuiltIn         gl_MaxTessEvaluationAtomicCounterBuffers
syn keyword glslBuiltIn         gl_MaxGeometryAtomicCounterBuffers
syn keyword glslBuiltIn         gl_MaxFragmentAtomicCounterBuffers
syn keyword glslBuiltIn         gl_MaxCombinedAtomicCounterBuffers gl_MaxAtomicCounterBufferSize
syn keyword glslBuiltIn         gl_MinProgramTexelOffset gl_MaxProgramTexelOffset
syn keyword glslBuiltIn         __FILE__ __LINE__ __VERSION__

" Built-in Functions
syn keyword glslBuiltInFunc     radians degrees sin cos tan asin acos atan sinh cosh tan asinh acosh atanh
syn keyword glslBuiltInFunc     pow exp log exp2 log2 sqrt inversesqrt
syn keyword glslBuiltInFunc     abs sign floor trunc round roundEven ceil fract mod modf min max
syn keyword glslBuiltInFunc     clamp mix step smoothstep isnan isinf
syn keyword glslBuiltInFunc     floatBitsToInt floatBitstoUint intBitsToFloat
syn keyword glslBuiltInFunc     fma frexp ldexp
syn keyword glslBuiltInFunc     packUnorm2x16 packSnorm2x16 packUnorm4x8 packSnorm4x8
syn keyword glslBuiltInFunc     unpackUnorm2x16 unpackSnorm2x16 unpackUnorm4x8 unpackSnorm4x8
syn keyword glslBuiltInFunc     packDouble2x32 unpackDouble2x32 packHalf2x16 unpackHalf2x16
syn keyword glslBuiltInFunc     length distance dot cross normalize faceforward reflect refract
syn keyword glslBuiltInFunc     matrixCompMult outerProduct transpose determinant inverse
syn keyword glslBuiltInFunc     lessThan lessThanEqual greaterThan greaterThanEqual equal notEqual
syn keyword glslBuiltInFunc     any all not
syn keyword glslBuiltInFunc     uaddCarry usubBorrow umulExtended imulExtended
syn keyword glslBuiltInFunc     bitfieldExtract bitfieldInsert bitfieldReverse bitCount findLSB findMSB
syn keyword glslBuiltInFunc     textureSize textureQueryLod
syn keyword glslBuiltInFunc     texture textureProj textureLod textureOffset
syn keyword glslBuiltInFunc     texelFetch texelFetchOffset textureProjOffset textureLodOffset
syn keyword glslBuiltInFunc     textureProjLod textureProjLodOffset
syn keyword glslBuiltInFunc     textureGrad textureGradOffset textureProjGrad textureProjGradOffset
syn keyword glslBuiltInFunc     textureGather textureGatherOffset textureGatherOffsets
syn keyword glslBuiltInFunc     atomicCounterIncrement, atomicCounterDecrement, atomicCounter
syn keyword glslBuiltInFunc     imageLoad imageStore imageAtomicAdd imageAtomicMin imageAtomicMax
syn keyword glslBuiltInFunc     imageAtomicAnd imageAtomicOr imageAtomicXor imageAtomicExchange
syn keyword glslBuiltInFunc     imageAtomicCompSwap
syn keyword glslBuiltInFunc     dFdx dFdy fwidth
syn keyword glslBuiltInFunc     interpolateAtCentroid interpolateAtSample interpolateAtOffset
syn keyword glslBuiltInFunc     noise1 noise2 noise3 noise4
syn keyword glslBuiltInFunc     EmitStreamVertex EndStreamPrimitive EmitVertex EndPrimitive
syn keyword glslBuiltInFunc     barrier memoryBarrier

" Compatibility Built-in Variables
syn keyword glslBuiltIn         gl_ClipVertex gl_TexCoord gl_FogCoord gl_FogFragCoord
syn keyword glslBuiltIn         gl_Color gl_SecondaryColor gl_FragColor gl_FragData
syn keyword glslBuiltIn         gl_FrontColor gl_BackColor gl_FrontSecondaryColor gl_BackSecondaryColor
syn keyword glslBuiltIn         gl_Normal gl_Vertex
syn match   glslBuiltIn         display "gl_MultiTexCoord[0-7]"

syn keyword glslBuiltIn         gl_ModelViewMatrix gl_ProjectionMatrix gl_ModelViewProjectionMatrix
syn keyword glslBuiltIn         gl_TextureMatrix gl_NormalMatrix
" TODO: More of the same...

" Compatibility Built-in Constants
syn keyword glslBuiltIn         gl_MaxTextureUnits gl_MaxTextureCoords gl_MaxClipPlanes gl_MaxVaryingFloats

" Compatibility Built-in Functions
syn keyword glslBuiltInFunc     ftransform
" TODO: texture

" gl_ reserved prefix
syn match   glslReservedIdent   "\<gl_\w*\>"

" Comments
syn keyword glslTodo            contained TODO FIXME XXX
syn cluster glslCommentGroup    contains=glslTodo
syn region  glslComment         start="/\*" end="\*/" contains=@glslCommentGroup,@Spell
syn region  glslLineComment     start="//.*" skip="\\$" end="$" contains=@glslCommentGroup,@Spell

" Preprocessor
syn cluster glslPreProcGroup    contains=glslDefine,glslExtension,glslVersion,glslPreProcDirect,glslPreCondit
syn region  glslDefine          start="^\s*#\s*\(define\|undef\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@glslPreProcGroup,@Spell
syn region  glslExtension       start="^\s*#\s*extension\>" skip="\\$" end="$" keepend contains=ALLBUT,@glslPreProcGroup,@Spell
syn region  glslVersion         start="^\s*#\s*version\>" skip="\\$" end="$" keepend contains=glslInteger,glslVersionProfile
syn keyword glslVersionProfile  contained core compatibility
syn region  glslPreProcDirect   start="^\s*#\s*\(error\|pragma\|line\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@glslPreProcGroup,@Spell
" TODO: PreCondit highlights `#if` as a keyword.
syn region  glslPreCondit       start="^\s*#\s*\(if\|ifdef\|ifndef\|else\|elif\|endif\)\>" skip="\\$" end="$" keepend contains=ALLBUT,@glslPreProcGroup,@Spell

" Highlighting
hi def link glslStructDecl      Structure
hi def link glslStorageClass    StorageClass
hi def link glslInterpolation   StorageClass
hi def link glslPrecision       StorageClass
hi def link glslInvariant       StorageClass
hi def link glslMemory          StorageClass
hi def link glslReserved        Error
hi def link glslType            Type
hi def link glslLayout          StorageClass
hi def link glslLayoutName      Keyword

hi def link glslBoolean         Boolean
hi def link glslInteger         Number
hi def link glslFloat           Float

hi def link glslConditional     Conditional
hi def link glslRepeat          Repeat
hi def link glslLabel           Label
hi def link glslStatement       Statement
hi def link glslOperator        Operator

hi def link glslBuiltIn         Identifier
hi def link glslBuiltInFunc     Function
hi def link glslReservedIdent   Error

hi def link glslTodo            Todo
hi def link glslComment         Comment
hi def link glslLineComment     Comment

hi def link glslDefine          Define
hi def link glslExtension       PreProc
hi def link glslVersion         PreProc
hi def link glslVersionProfile  Keyword
hi def link glslPreProcDirect   PreProc
hi def link glslPreCondit       PreCondit
