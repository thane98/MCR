.arm.little

.open "code.bin","build/exefs/code.bin",0x100000

; Functions
Event_ScriptLoad equ 0x422398
CMVM_DoInstruction_Resume equ 0x3DB654
GameUserData_Get equ 0x1b3afc
strncpy equ 0x11b0dc
Person_GetByPID equ 0x44A6DC
UnitPool_GetFromPerson equ 0x4F5D24
UnitPool_GetPlayer equ 0x4f6340
castle_Actor_GetUnit equ 0x541940
castle_Sequence_TickMoveUnit_AmiiboCase equ 0x498E78
castle_People_Data_GetByPerson equ 0x492a5c
Castle_Get equ 0x44544c
Castle_GetData equ 0x44545c
malloc equ 0x113b6c
castle_People_Data_Constructor equ 0x493bf8
Unit_IsFemale equ 0x533938

; Overwritten functions
ev_DialogSeven equ 0x3b0018
cmvm_CmDebugSource_NewVar equ 0x3d9b18
debug_menu_MoveToNext equ 0x421114

; Hooks
CMVM_UnusedInstruction3A equ 0x3DA26C
LilithFoodPath equ 0x6A3DAB
MainSeqInitialize_Hook equ 0x1B61E0
MainSeqInitialize_Resume equ 0x1B61E4
castle_CastleSound_ResumeMainBgm_PitchGet equ 0x44ee48
castle_CastleSound_ResumeMainBgm_EnvironmentSoundsGet equ 0x44eea0
castle_CastleSound_PlayMainBgm_PitchGet equ 0x44ecf8
castle_CastleSound_PlayMainBgm_EnvironmentSoundsGet equ 0x44ed50
castle_cut_GetCID equ 0x46985c
castle_SetWorldTime_GetTimeCall equ 0x178228
castle_JukeBox_GetBgmLabel equ 0x494620
castle_CastleSeq_DataInitialize_Branch equ 0x49afc0
castle_FirstEnterSequence_CreateDisposBind_Branch equ 0x45c188
castle_cut_InitBuildingDispos_Hook equ 0x468158
castle_cut_InitBuildingDispos_Resume equ 0x46815C
castle_CastleWorld_GetBuildingDispos equ 0x53f264
castle_BuildingDispos_Reset equ 0x455548
castle_cut_InitBuildingDispos_RouteSetSelect equ 0x468278
castle_CastleSeq_Initialize_PlayerLoad equ 0x49a990
castle_Seq_Setup_RepositionHook equ 0x472A60
castle_Seq_Initialize_RepositionPlayerHook equ 0x49ae04
castle_AmiiboTalkSequence_CreateBind_Hook_1 equ 0x45BB20
castle_AmiiboTalkSequence_CreateBind_Script_Path_Template equ 0x45bbc8
castle_AmiiboTalkSequence_CreateBind_Script_Function_Template equ 0x45bbd8
castle_AmiiboTalkSequence_CreateBind_Script_Path_Hook equ 0x45bb60
castle_AmiiboTalkSequence_CreateBind_Script_Function_Hook equ 0x45bb7c
castle_AmiiboSeq_PostTalk equ 0x491150
castle_AmiiboSeq_PostTalk_End equ 0x491260
castle_Sequence_TickMoveUnit_ButlerCase equ 0x498bf4
castle_Sequence_TickMoveUnit_StandardUnitCase equ 0x498DD4
castle_Sequence_TickMoveUnit_Case0x4 equ 0x498dc0
castle_SetupAreaExits_LoadDefaults equ 0x46bdac
castle_SetupAreaExits_LoadMuse equ 0x46bde4
CounterScene_CounterScene_Hook equ 0x1ad4c8
castle_Seq_CheckElapsedTime_UpdatePeopleTimeHook equ 0x49babc
castle_People_Deserialize_Hook1 equ 0x492814
castle_People_Deserialize_Hook2 equ 0x4929e4
castle_CastleUserData_GetTimeHour equ 0x540a48
castle_AmiiboSeq_Load equ 0x47cb48
castle_AmiiboSeq_Free equ 0x47cb20
castle_Seq_Initialize_GetStructHook equ 0x49ab9c
castle_Seq_Initialize_Begin equ 0x49a970
castle_Seq_Initialize_End equ 0x49ae9c
castle_Seq_Initialize_Loop equ 0x49ac2c
castle_Seq_Initialize_LoopEnd equ 0x49accc
castle_CastleSeq_CreateActors_LoopStart equ 0x499ec4
castle_CastleSeq_CreateActors_LoopStep equ 0x499ff8

; TODO: FIX NAMES
CastleLowerDrawer_DrawButtons equ 0x200BF4
CastleLowerDrawer_Draw_DrawTimeCall equ 0x200c50
DrawCastleInfo_CastleName equ 0x2002bc
DrawCastleInfo_DVPText equ 0x200424
DrawCastleInfo_DVPIcon equ 0x200458
DrawCastleInfo_DVPBar equ 0x2002F4
SetupCastleInfo_AfterNameItem equ 0x200ACC
SetupCastleInfo_AfterDVPItem equ 0x200B18
CrystalDrawIcon equ 0x20075C
CrystalNeedFlash equ 0x466C24
CastleHelpFrameDraw_Loop equ 0x542ED8
ButlerMenuCreateBind equ 0x44D5B8
MoveUnitRelianceMenuCheck equ 0x498f58
MoveUnitLinkMenuCheck equ 0x498f60
EnterSeq_Tutorial equ 0x47f520
EnterSeq_TutorialNotice equ 0x47f340
EnterSeq_TutorialAfterLilith equ 0x47f424
CastleAssignEvent_Hook_1 equ 0x492b7c
CastleAssignEvent_Hook_2 equ 0x4937f4
CastleAssignEvent_Shopkeepers_Loop equ 0x4936cc
CastleAssignEvent_Shopkeepers equ 0x49377c
CastleAssignEvent_Conversations equ 0x493960

; Repurpose code that loads a file we don't need.
; We'll make it load MCR data instead.
.org LilithFoodPath
    .sjis "castle/mcr.bin"

; Load an extra global script.
.org MainSeqInitialize_Hook
    b LoadMCRGlobalScript

; Repurpose an unused CMVM instruction to execute custom code.
.org CMVM_UnusedInstruction3A
    .word CustomCMVMFunc

.org castle_JukeBox_GetBgmLabel
    push lr
    bl GetMCRStage
    ldr r0, [r0, #4]
    pop pc

.org castle_CastleSound_ResumeMainBgm_PitchGet
    bl GetStagePitch
    nop
    nop
    nop

.org castle_CastleSound_PlayMainBgm_PitchGet
    bl GetStagePitch
    nop
    nop
    nop

.org castle_cut_GetCID
    b GetStageCID

.org castle_SetWorldTime_GetTimeCall
    bl GetWorldTime
    nop

.org castle_CastleSeq_DataInitialize_Branch
    nop  ; ALWAYS branch to FirstEnterSeq so we place a new set of buildings.
.org castle_FirstEnterSequence_CreateDisposBind_Branch
    nop  ; ALWAYS branch to FirstEnterSeq so we place a new set of buildings.

.org castle_cut_InitBuildingDispos_Hook
    b ResetBuildingsForPlacement

.org castle_cut_InitBuildingDispos_RouteSetSelect
    bl GetStageBuildings

.org castle_CastleSeq_Initialize_PlayerLoad
    bl GetStagePlayerUnit

.org castle_Seq_Setup_RepositionHook
    bl SetNormalActorPosition

.org castle_Seq_Initialize_RepositionPlayerHook
    bl SetPlayerActorPosition

.org castle_AmiiboTalkSequence_CreateBind_Hook_1
    mov r0, #0  ; No need to find the amiibo type here. We don't use it.

.org castle_AmiiboTalkSequence_CreateBind_Script_Path_Template
    .sjis "mcr/%s"

.org castle_AmiiboTalkSequence_CreateBind_Script_Function_Template
    .sjis "mcr::talk_%s"

.org castle_AmiiboTalkSequence_CreateBind_Script_Path_Hook
    bl SetupAmiiboScriptRedirect

.org castle_AmiiboTalkSequence_CreateBind_Script_Function_Hook
    bl SetupAmiiboFunctionRedirect

.org castle_AmiiboSeq_PostTalk
    b castle_AmiiboSeq_PostTalk_End  ; Stub out this function so we don't unlock amiibo chapters.

.org castle_Sequence_TickMoveUnit_ButlerCase
    b castle_Sequence_TickMoveUnit_AmiiboCase

.org castle_Sequence_TickMoveUnit_StandardUnitCase
    mov r0, r5
    b castle_Sequence_TickMoveUnit_AmiiboCase

.org castle_SetupAreaExits_LoadDefaults
    bl GetStageExits

.org castle_SetupAreaExits_LoadMuse
    nop

.org castle_CastleSound_PlayMainBgm_EnvironmentSoundsGet
    bl GetStageEnvironmentSounds

.org castle_CastleSound_ResumeMainBgm_EnvironmentSoundsGet
    bl GetStageEnvironmentSounds

.org CounterScene_CounterScene_Hook
    bl GetStagePlayerUnitForCounterScene

; Disabling customizations / base building.
.org EnterSeq_Tutorial
    nop
    nop
    nop
.org EnterSeq_TutorialNotice
    nop
.org EnterSeq_TutorialAfterLilith
    bx lr
.org MoveUnitRelianceMenuCheck
    ; Disable the bookshelf.
    mov r0, #-1
.org MoveUnitLinkMenuCheck
    ; Disable the crystal ball.
    mov r0, #-1
.org CastleLowerDrawer_DrawButtons
    ; Hide the card/castle/army buttons and disable their functionality.
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
    nop
.org DrawCastleInfo_DVPText
    nop
.org DrawCastleInfo_DVPIcon
    nop
.org DrawCastleInfo_DVPBar
    nop
.org CastleLowerDrawer_Draw_DrawTimeCall
    nop
.org SetupCastleInfo_AfterNameItem
    ; Disable DVP item interaction.
    b SetupCastleInfo_AfterDVPItem
.org CrystalDrawIcon
    ; Don't make the crystal glow on the map.
    nop
.org CrystalNeedFlash
    ; Disable balloons for the crystal.
    mov r0, #0
    bx lr
.org CastleHelpFrameDraw_Loop
    ; Hide the castle menu button prompt.
    cmp r4, #4
.org ButlerMenuCreateBind
    ; Disable the butler / castle menu sequence
    bx lr
.org DrawCastleInfo_CastleName
    nop

; Force everyone to deploy outside
.org CastleAssignEvent_Shopkeepers
    ; Only use generic shopkeepers.
    mov r0, #0
.org CastleAssignEvent_Hook_1
    ; Skip straight to assigning shopkeepers.
    b CastleAssignEvent_Shopkeepers_Loop
.org CastleAssignEvent_Hook_2
    ; Skip to normal conversations (no speech bubble).
    b CastleAssignEvent_Conversations
.org CastleAssignEvent_Conversations
    ; Always deploy all characters in the army.
    ; 60 is arbitrary. Increase it if you have more
    ; characters than that.
    nop
    mov r4, #0
    mov r5, #60

.org castle_Seq_CheckElapsedTime_UpdatePeopleTimeHook
    ; Make sure that we do NOT reset people data unexpectedly.
    ; This is required to persist talk status correctly during saves.
    nop

; By default, the talk status field is treated like a boolean.
; We support more than 2 states, so don't reduce this to 0 or 1.
.org castle_People_Deserialize_Hook1
    mov r1, r0
    nop
    nop
.org castle_People_Deserialize_Hook2
    mov r1, r0
    nop
    nop

.org castle_CastleUserData_GetTimeHour
    ; Don't update the world time when the player exits MyCastle.
    push lr
    bl GetWorldTime
    pop pc

.org castle_AmiiboSeq_Load
    bl GetMCRStageId
    nop

.org castle_AmiiboSeq_Free
    bl GetMCRStageId
    nop

.org castle_Seq_Initialize_Begin
    ; Push r10-r11 so we can use them without reworking register usage for the function.
    push {r4-r11, lr}
.org castle_Seq_Initialize_End
    pop {r4-r11, pc}
.org castle_Seq_Initialize_GetStructHook
    ; Don't have a lot of room to set up the loop here.
    ; Let's do it somewhere else.
    b CollisionMeshLoopStart
CollisionMeshLoopBody:
    ; Not loading using StructList::GetSurely anymore, so get the data
    ; from the stage's list instead.
    mov r0, r9
.org castle_Seq_Initialize_Loop
    ; Overwrite code for creating the throne and use it for a loop to
    ; create all of the collision meshes instead.
    add r9, #4
    sub r11, #1
CollisionMeshLoopCheck:
    cmp r11, #0
    beq castle_Seq_Initialize_LoopEnd
    b CollisionMeshLoopBody
CollisionMeshLoopStart:
    bl GetStageCollisionMeshes
    ldr r11, [r0]
    add r9, r0, #4
    b CollisionMeshLoopCheck

.org castle_CastleSeq_CreateActors_LoopStart
    bne ReplacePeopleDataList

.org debug_menu_MoveToNext
GetMCRStage:
    push lr

    ; Get the stage index
    bl GameUserData_Get
    ldr r0, [r0, #0x20]
    ldr r0, [r0, #0xC]
    mov r1, #47
    ldr r2, [r0, r1, LSL 2]

    ; Get the stage data
    adr r0, MCRDataAddr
    ldr r0, [r0]
    ldr r0, [r0]
    add r0, r0, #4
    mov r1, #8
    mul r1, r2, r1
    add r0, r1
    pop pc

MCRDataAddr:
    .word 0x6d2024

GetStagePitch:
    push lr
    bl GetMCRStage
    ldr r0, [r0, #8]
    .word 0xEE000A10  ; vmov s0, r0
    pop pc

GetStageCID:
    push {r4, lr}
    mov r4, r0
    bl GetMCRStage
    ldr r1, [r0]
    mov r0, r4
    mov r2, #0x10
    bl strncpy
    pop {r4, pc}

GetWorldTime:
    push lr
    bl GetMCRStage
    ldr r0, [r0, #0xC]
    .word 0xEE000A10  ; vmov s0, r0
    pop pc

ResetBuildingsForPlacement:
    push {r0-r3, lr}
    bl castle_CastleWorld_GetBuildingDispos
    bl castle_BuildingDispos_Reset
    pop {r0-r3, lr}
    ldr r0, [r0]
    b castle_cut_InitBuildingDispos_Resume

GetStageBuildings:
    push {r1-r3, lr}
    bl GetMCRStage
    ldr r0, [r0, #0x10]
    pop {r1-r3, pc}

GetStagePlayerUnit:
    push lr
    bl GetMCRStage
    ldr r0, [r0, #0x14]
    bl Person_GetByPID
    bl UnitPool_GetFromPerson
    pop pc
GetStagePlayerUnitDefault:
    bl UnitPool_GetPlayer
    pop pc

GetStageActors:
    push {r1-r3, lr}
    bl GetMCRStage
    ldr r0, [r0, #0x18]
    pop {r1-r3, pc}

GetMCRStageId:
    push lr
    bl GetMCRStage
    ldr r0, [r0, #0x1C]
    pop pc

GetStageExits:
    push {r0, lr}
    bl GetMCRStage
    ldr r1, [r0, #0x20]
    ldr r2, [r0, #0x24]
    ldr r3, [r0, #0x28]
    pop {r0, pc}

GetStageEnvironmentSounds:
    push {r1-r3, lr}
    bl GetMCRStage
    ldr r0, [r0, #0x2C]
    pop {r1-r3, pc}

GetStagePlayerUnitForCounterScene:
    push {r0-r1, r3, lr}
    mov r4, r0  ; Performing overwritten instruction
    bl GetStagePlayerUnit
    mov r2, r0
    pop {r0-r1, r3, pc}

GetActorByPersonId:
    push {r4, lr}
    mov r2, r0           ; r2=Target ID
    bl GetStageActors
    ldr r3, [r0]         ; r3=end index
    mov r1, #0           ; r1=current index
    add r4, r0, #4       ; r4=next character
GetActorByPersonIdLoopTop:
    ; while r1 < r3
    cmp r1, r3
    movge r0, #0
    bge GetActorByPersonIdDone
    ; if current id == target id
    ldrh r0, [r4, #0x1A]
    cmp r0, r2
    beq GetActorByPersonIdCheckSuccess
    ; if current_id == 0 && target_id <= 2
    cmp r0, #0
    bne GetActorByPersonIdStep
    cmp r2, #2
    ble GetActorByPersonIdCheckSuccess
    b GetActorByPersonIdStep
GetActorByPersonIdCheckSuccess:
    ; return the actor
    mov r0, r4
    b GetActorByPersonIdDone
GetActorByPersonIdStep:
    ; try the next index
    add r1, #1
    add r4, #28
    b GetActorByPersonIdLoopTop
GetActorByPersonIdDone:
    pop {r4, pc}

SetPlayerActorPosition:
    push {r1-r4, lr}
    bl GetMCRStage
    cmp r0, #0
    beq SetPlayerActorPositionDone
    ldr r1, [r0, #0x34]
    ldr r0, [r0, #0x30]
    .word 0xEE000A10  ; vmov s0, r0
    .word 0xEE011A10  ; vmov s1, r1
SetPlayerActorPositionDone:
    .word 0xEC8D0A03  ; vstmia sp=>local_40,{s0,s1,s2}
    pop {r1-r4, pc}

SetNormalActorPosition:
    push {r1-r4, lr}
    mov r0, r8
    bl castle_Actor_GetUnit
    cmp r0, #0
    beq SetActorPositionDone
    ldr r0, [r0, #0x9C]
    cmp r0, #0
    beq SetActorPositionDone
    ldrh r0, [r0, #0x24]
    bl GetActorByPersonId
    cmp r0, #0
    beq SetActorPositionDone
    ldr r1, [r0, #4]
    ldr r0, [r0]
    .word 0xEE000A10  ; vmov s0, r0
    .word 0xEE011A10  ; vmov s1, r1
SetActorPositionDone:
    mov r0, r8
    pop {r1-r4, pc}

GetPidNoPrefixFromCastleActor:
    ldr r0, [r0, #0x9C]
    cmp r0, #0
    beq GetPidNoPrefixFromCastleActorDone
    ldr r0, [r0, #0x8]
    cmp r0, #0
    beq GetPidNoPrefixFromCastleActorDone
    add r0, #4
GetPidNoPrefixFromCastleActorDone:
    bx lr

SetupAmiiboScriptRedirect:
    push {r0-r2, lr}
    bl GetMCRStageId
    mov r3, r0
    pop {r0-r2, pc}

SetupAmiiboFunctionRedirect:
    push {r0-r2, lr}
    mov r0, r5
    bl GetPidNoPrefixFromCastleActor
    cmp r0, #0
    adreq r0, SetupAmiiboFunctionRedirectDefaultName
    mov r3, r0
    pop {r0-r2, pc}
SetupAmiiboFunctionRedirectDefaultName:
    .sjis "default"

GetStageCollisionMeshes:
    push lr
    bl GetMCRStage
    ldr r0, [r0, #0x38]
    pop pc

ReplacePeopleDataList:
    ; Explanation: We get a linked list of people data, but it probably won't have the actors
    ; that we want. Need to overwrite with the characters we want and resize to fit the amount
    ; of units in the stage's data.
    ; r4 = current node (castle::People::Data)
    ; r5 = next node (or nullptr)
    ; r6 = current entry in stage actors list
    ; r7 = address of stage actors list end
    push {r4-r7, lr}
    bl GetStageActors
    add r6, r0, #4
    ldr r7, [r0]
    mov r0, #28
    mul r7, r7, r0
    add r7, r6
ReplacePeopleDataListLoop:
    ; Exit if at end of stage actors list.
    cmp r6, r7
    beq ReplacePeopleDataListFinalize
ReplacePeopleDataListLoopBody:
    ; Overwrite the character ID
    ; TODO: Player character
    ldrh r0, [r6, #0x1A]
    cmp r0, #0
    bne ReplacePeopleDataOverwriteCharacter
    bl UnitPool_GetPlayer
    bl Unit_IsFemale
    add r0, #1
ReplacePeopleDataOverwriteCharacter:
    strh r0, [r4, #0x1A]
    ; Move them outdoors.
    mov r0, #3
    strb r0, [r4, #0x2D]
    ; Step forward
    add r6, #28
    ldr r5, [r4, #4]
    ; Have we run off the people data list?
    cmp r5, #0
    movne r4, r5
    bne ReplacePeopleDataListLoop
    ; If so, we need to malloc an entry and add it to the list.
    mov r0, #0x38
    bl malloc
    cmp r0, #0
    beq ReplacePeopleDataListDone
    mov r5, r0
    bl castle_People_Data_Constructor
    mov r4, r5
    b ReplacePeopleDataListLoop
ReplacePeopleDataListFinalize:
    ; Ran out of actors before reaching the end of people data.
    ; The rest should be hidden.
    cmp r4, #0
    beq ReplacePeopleDataListDone
    mov r0, #0
    sub r0, #1
    strh r0, [r4, #0x1A]
    strb r0, [r4, #0x2D]
    ldr r4, [r4, #4]
    b ReplacePeopleDataListFinalize
ReplacePeopleDataListDone:
    pop {r4-r7, lr}
    b castle_CastleSeq_CreateActors_LoopStep

.org 0x499f60
    ; Probably need this in more places to allow loading from the "absent" army.
    mov r1, #63

.org cmvm_CmDebugSource_NewVar
LoadMCRGlobalScript:
    bl Event_ScriptLoad
    adr r0, MCRGlobalScriptName
    bl Event_ScriptLoad
    b MainSeqInitialize_Resume

MCRGlobalScriptName:
    .sjis "mcr"

.org ev_DialogSeven
CustomCMVMFunc:
    push {r0-r7, lr}
    mov r0, #1
    bl IncCMVMPC
    bl PopCMVMStack
    cmp r0, #4
    bge CustomCMVMFuncComplete
    adr r1, CustomCMVMFuncTable
    ldr r0, [r1, r0, LSL 2]
    bx r0

CustomCMVMFuncComplete:
    bl PushCMVMStack
    pop {r0-r7, lr}
    b CMVM_DoInstruction_Resume

CustomCMVMFuncTable:
    .word VarSetIndex
    .word VarGetIndex
    .word GetActorTalkStatus
    .word SetActorTalkStatus

VarSetIndex:
    bl GameUserData_Get
    ldr r0, [r0, #0x20]
    ldr r5, [r0, #0xC]
    bl PopCMVMStack
    mov r2, r0
    bl PopCMVMStack
    str r2, [r5, r0, LSL 2]
    mov r0, #1
    b CustomCMVMFuncComplete

VarGetIndex:
    bl GameUserData_Get
    ldr r0, [r0, #0x20]
    ldr r5, [r0, #0xC]
    bl PopCMVMStack
    ldr r0, [r5, r0, LSL 2]
    b CustomCMVMFuncComplete

GetActorTalkStatus:
    bl PopCMVMStack
    bl PIDToCastlePeopleData
    cmp r0, #0
    beq CustomCMVMFuncComplete
    ldrb r0, [r0, #0x34]
    b CustomCMVMFuncComplete

SetActorTalkStatus:
    bl PopCMVMStack
    mov r5, r0
    bl PopCMVMStack
    bl PIDToCastlePeopleData
    cmp r0, #0
    beq CustomCMVMFuncComplete
    strb r5, [r0, #0x34]
    b CustomCMVMFuncComplete

PIDToCastlePeopleData:
    push {r4, lr}
    bl Person_GetByPID
    mov r4, r0
    bl Castle_Get
    bl Castle_GetData
    ldr r0, [r0, #0xC]
    mov r1, r4
    bl castle_People_Data_GetByPerson
    pop {r4, pc}


PopCMVMStack:
    ldr r0, [r4, #0x18]
    sub r0, r0, #4
    str r0, [r4, #0x18]
    ldr r0, [r0, #0]
    bx lr

PushCMVMStack:
    ldr r1, [r4, #0x18]
    str r0, [r1]
    add r1, r1, #4
    str r1, [r4, #0x18]
    bx lr

IncCMVMPC:
    ldr r1, [r4, #0x10]
    add r1, r0, r1
    str r1, [r4, #0x10]
    bx lr

.close
