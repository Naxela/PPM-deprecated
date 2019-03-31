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
        self.inputs.new('NodeSocketFloat', 'End Float')
        self.inputs.new('NodeSocketFloat', 'Duration')
        self.inputs.new('NodeSocketBool', 'Stop Interpolation')
        self.outputs.new('NodeSocketFloat', 'Float')
        
add_node(LerpFloatNode, category='PPM+')
