import bpy
from bpy.props import *
from bpy.types import Node, NodeSocket
from arm.logicnode.arm_nodes import *

class DOFSetNode(Node, ArmLogicTreeNode):
    '''Set DOF Effect'''
    bl_idname = 'LNDOFSetNode'
    bl_label = 'Set DOF'
    bl_icon = 'QUESTION'

    def init(self, context):
        self.inputs.new('ArmNodeSocketAction', 'In')
        self.inputs.new('NodeSocketBool', 'Auto Focus')
        self.inputs[-1].default_value = True
        self.inputs.new('NodeSocketFloat', 'Distance')
        self.inputs[-1].default_value = 10.0
        self.inputs.new('NodeSocketFloat', 'Length')
        self.inputs[-1].default_value = 160.0
        self.inputs.new('NodeSocketFloat', 'F-Stop')
        self.inputs[-1].default_value = 128.0
        self.inputs.new('NodeSocketFloat', 'Focus X')
        self.inputs[-1].default_value = 0.5
        self.inputs.new('NodeSocketFloat', 'Focus Y')
        self.inputs[-1].default_value = 0.5
        self.inputs.new('NodeSocketFloat', 'Circle of confusion')
        self.inputs[-1].default_value = 0.11
        self.inputs.new('NodeSocketFloat', 'Maxblur')
        self.inputs[-1].default_value = 1.0
        self.inputs.new('NodeSocketFloat', 'Threshold')
        self.inputs[-1].default_value = 0.5
        self.inputs.new('NodeSocketFloat', 'Gain')
        self.inputs[-1].default_value = 2.0
        self.inputs.new('NodeSocketFloat', 'Bias')
        self.inputs[-1].default_value = 0.5
        self.inputs.new('NodeSocketFloat', 'Fringe')
        self.inputs[-1].default_value = 0.7
        self.outputs.new('ArmNodeSocketAction', 'Out')

#add_node(DOFSetNode, category='PPM')
