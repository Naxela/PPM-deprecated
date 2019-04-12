import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class LerpFloatNode(Node, ArmLogicTreeNode):
    '''Lerp Float node'''
    bl_idname = 'LNLerpFloatNode'
    bl_label = 'Lerp Floats'
    bl_icon = 'QUESTION'

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'In')
        self.inputs.new('NodeSocketFloat', 'Starting Float')
        self.inputs[-1].default_value = 0.0
        self.inputs.new('NodeSocketFloat', 'End Float')
        self.inputs[-1].default_value = 1.0
        self.inputs.new('NodeSocketFloat', 'Duration')
        self.inputs[-1].default_value = 2.0
        self.inputs.new('NodeSocketBool', 'Stop Interpolation')
        self.outputs.new('NodeSocketFloat', 'Float')
        self.outputs.new('NodeSocketBool', 'Running')
        
add_node(LerpFloatNode, category='PPM+')
