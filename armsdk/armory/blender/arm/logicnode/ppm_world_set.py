import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class WorldSetNode(Node, ArmLogicTreeNode):
    '''Set World Effect'''
    bl_idname = 'LNWorldSetNode'
    bl_label = 'Set World'
    bl_icon = 'QUESTION'

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'In')
        self.inputs.new('NodeSocketColor', 'Volumetric Fog Color')
        self.inputs.new('NodeSocketFloat', 'Volumetric Fog A')
        self.inputs.new('NodeSocketFloat', 'Volumetric Fog B')
        self.inputs.new('NodeSocketColor', 'Volumetric Light Color')
        self.inputs.new('NodeSocketFloat', 'Volumetric Light Turbidity')
        self.inputs.new('NodeSocketFloat', 'Volumetric Lights Steps')
        self.inputs.new('NodeSocketFloat', 'SSR Step')
        self.inputs.new('NodeSocketFloat', 'SSR Step Min')
        self.inputs.new('NodeSocketFloat', 'SSR Search')
        self.inputs.new('NodeSocketFloat', 'SSR Falloff')
        self.inputs.new('NodeSocketFloat', 'SSR Jitter')
        self.inputs.new('NodeSocketFloat', 'SSRS Step')


        self.outputs.new('ArmNodeSocketAction', 'Out')

add_node(WorldSetNode, category='PPM')
