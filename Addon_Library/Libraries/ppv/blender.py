import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *
import arm
import arm.assets as assets
import arm.nodes_logic
import arm.props_ui
import arm.utils
import refresh_menu
from ppv_nodes import *
from arm.exporter import ArmoryExporter

def update_renderpath(self, context):
    if assets.invalidate_enabled == False:
        return
    assets.invalidate_shader_cache(self, context)
    bpy.data.worlds['Arm'].arm_recompile = True

#def writePPV():
#    ArmoryExporter.import_traits.append("armory.traits.PPV_run")

bpy.types.World.arm_ppv = BoolProperty(name="PPV", description="Post-Process Volumes - Adjustable realtime shaders", default=False, update=update_renderpath)
#print("LOC:"+arm.utils.get_fp())

#bpy.utils.unregister_class(VIEW3D_PT_view3d_cursor)

def on_make_renderpath():
    bpy.data.worlds["Arm"].arm_minimize = False
    assets.add_shader_pass('copy_pass')

    #if(bpy.data.worlds["Arm"].arm_khafile == ""):
        #bpy.ops.text.new()
        #bpy.data.texts[-1].name = "ArmKhaFile"

    #ArmoryExporter.import_traits.append("armory.traits.PPV_run")
    #on_make_renderpath ??? CONVERT SHADERS TO .ARM FORMAT?
    #pass
    #attachUI()
    #assets.a
    #assets.add_shader_data(arm.utils.get_fp() + "/Libraries/ppv/Shaders/ppv_pass/ppv_pass.json")
    #assets.add_shader_external(arm.utils.get_fp() + "/Libraries/ppv/Shaders/ppv_pass/ppv_pass.frag.glsl")
    #assets.add_shader_external(arm.utils.get_fp() + "/Libraries/ppv/Shaders/ppv_pass/ppv_pass.vert.glsl")
    #assets.add_shader_data(arm.utils.get_fp() + "/Shaders/ppv_pass/ppv_pass.json")
    #assets.add_shader_data(arm.utils.get_fp() + "/Shaders/ppv_pass/ppv_pass.json")
    #assets.add_shader_data(arm.utils.get_sdk_path() + "ppv_pass.json")
    if bpy.data.worlds['Arm'].arm_ppv:
        bpy.data.worlds['Arm'].compo_defs += '_CPPV'

def register():
    # Add custom nodes
    # TODO: separate into single .py file per logic node, similar to the main Armory repository
    # DONE!
    
    #rpdat = 
    #bpy.data.worlds['Arm'].arm_rplist[0].rp_ppv = bpy.props.BoolProperty(name="PPV", description="Depth Prepass for mesh context", default=False)
    #attachUI()

    arm.nodes_logic.register_nodes()
    arm.make_renderpath.callback = on_make_renderpath
    bpy.utils.register_class(refresh_menu.ArmRenderPathRendererPanel)
    bpy.utils.register_class(refresh_menu.ArmRenderPathShadowsPanel)
    bpy.utils.register_class(refresh_menu.ArmRenderPathVoxelsPanel)
    bpy.utils.register_class(refresh_menu.ArmRenderPathWorldPanel)
    bpy.utils.register_class(refresh_menu.ArmRenderPathPostProcessPanel)
    bpy.utils.register_class(refresh_menu.ArmRenderPathCompositorPanel)

def unregister():
    bpy.utils.unregister_class(refresh_menu.ArmRenderPathRendererPanel)
    bpy.utils.unregister_class(refresh_menu.ArmRenderPathShadowsPanel)
    bpy.utils.unregister_class(refresh_menu.ArmRenderPathVoxelsPanel)
    bpy.utils.unregister_class(refresh_menu.ArmRenderPathWorldPanel)
    bpy.utils.unregister_class(refresh_menu.ArmRenderPathPostProcessPanel)
    bpy.utils.unregister_class(refresh_menu.ArmRenderPathCompositorPanel)