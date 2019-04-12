import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class TonemapperSetNode(Node, ArmLogicTreeNode):
    '''Set Tonemapper Effect'''
    bl_idname = 'LNTonemapperSetNode'
    bl_label = 'Set Tonemapper'
    bl_icon = 'QUESTION'

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'In')
        self.inputs.new('NodeSocketFloat', 'Slope')
        self.inputs[-1].default_value = 2.51
        self.inputs.new('NodeSocketFloat', 'Toe')
        self.inputs[-1].default_value = 0.03
        self.inputs.new('NodeSocketFloat', 'Shoulder')
        self.inputs[-1].default_value = 2.43
        self.inputs.new('NodeSocketFloat', 'Black Clip')
        self.inputs[-1].default_value = 0.59
        self.inputs.new('NodeSocketFloat', 'White Clip')
        self.inputs[-1].default_value = 0.14

        self.outputs.new('ArmNodeSocketAction', 'Out')

add_node(TonemapperSetNode, category='PPM')
