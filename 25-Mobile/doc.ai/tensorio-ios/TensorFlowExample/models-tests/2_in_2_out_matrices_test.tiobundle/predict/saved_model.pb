ÿ>
ï

:
Add
x"T
y"T
z"T"
Ttype:
2	
x
Assign
ref"T

value"T

output_ref"T"	
Ttype"
validate_shapebool("
use_lockingbool(
8
Const
output"dtype"
valuetensor"
dtypetype
.
Identity

input"T
output"T"	
Ttype
q
MatMul
a"T
b"T
product"T"
transpose_abool( "
transpose_bbool( "
Ttype:

2	
e
MergeV2Checkpoints
checkpoint_prefixes
destination_prefix"
delete_old_dirsbool(
=
Mul
x"T
y"T
z"T"
Ttype:
2	

NoOp
M
Pack
values"T*N
output"T"
Nint(0"	
Ttype"
axisint 
C
Placeholder
output"dtype"
dtypetype"
shapeshape:
X
PlaceholderWithDefault
input"dtype
output"dtype"
dtypetype"
shapeshape
o
	RestoreV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
l
SaveV2

prefix
tensor_names
shape_and_slices
tensors2dtypes"
dtypes
list(type)(0
H
ShardedFilename
basename	
shard

num_shards
filename
N

StringJoin
inputs*N

output"
Nint(0"
	separatorstring 
P
	Transpose
x"T
perm"Tperm
y"T"	
Ttype"
Tpermtype0:
2	
s

VariableV2
ref"dtype"
shapeshape"
dtypetype"
	containerstring "
shared_namestring "serve*1.13.12
b'unknown'ý/
W
input1Placeholder*
shape
:*
dtype0*
_output_shapes

:
W
input2Placeholder*
dtype0*
_output_shapes

:*
shape
:
 
W/initial_valueConst*
dtype0*
_output_shapes

:*Y
valuePBN"@  ?      ?          ?      ?  ?      ?          ?      ?
u
W
VariableV2*
dtype0*
_output_shapes

:*
	container *
shape
:*
shared_name 

W/AssignAssignWW/initial_value*
use_locking(*
T0*
_class

loc:@W*
validate_shape(*
_output_shapes

:
T
W/readIdentityW*
T0*
_class

loc:@W*
_output_shapes

:
 
B/initial_valueConst*Y
valuePBN"@      ?      ?  ?      ?          ?      ?  ?      ?    *
dtype0*
_output_shapes

:
u
B
VariableV2*
shape
:*
shared_name *
dtype0*
_output_shapes

:*
	container 

B/AssignAssignBB/initial_value*
validate_shape(*
_output_shapes

:*
use_locking(*
T0*
_class

loc:@B
T
B/readIdentityB*
_output_shapes

:*
T0*
_class

loc:@B
_
transpose/permConst*
dtype0*
_output_shapes
:*
valueB"       
d
	transpose	TransposeW/readtranspose/perm*
Tperm0*
T0*
_output_shapes

:
r
MatMulMatMulinput1	transpose*
T0*
_output_shapes

:*
transpose_a( *
transpose_b( 
a
transpose_1/permConst*
valueB"       *
dtype0*
_output_shapes
:
h
transpose_1	TransposeB/readtranspose_1/perm*
Tperm0*
T0*
_output_shapes

:
v
MatMul_1MatMulinput2transpose_1*
T0*
_output_shapes

:*
transpose_a( *
transpose_b( 
I
output1MulMatMulMatMul_1*
T0*
_output_shapes

:
I
output2AddMatMulMatMul_1*
T0*
_output_shapes

:
"
initNoOp	^B/Assign	^W/Assign
Y
save/filename/inputConst*
dtype0*
_output_shapes
: *
valueB Bmodel
n
save/filenamePlaceholderWithDefaultsave/filename/input*
dtype0*
_output_shapes
: *
shape: 
e

save/ConstPlaceholderWithDefaultsave/filename*
dtype0*
_output_shapes
: *
shape: 
e
save/SaveV2/tensor_namesConst*
valueBBBBW*
dtype0*
_output_shapes
:
g
save/SaveV2/shape_and_slicesConst*
valueBB B *
dtype0*
_output_shapes
:
q
save/SaveV2SaveV2
save/Constsave/SaveV2/tensor_namessave/SaveV2/shape_and_slicesBW*
dtypes
2
}
save/control_dependencyIdentity
save/Const^save/SaveV2*
_output_shapes
: *
T0*
_class
loc:@save/Const
h
save/RestoreV2/tensor_namesConst*
valueBBBBW*
dtype0*
_output_shapes
:
j
save/RestoreV2/shape_and_slicesConst*
dtype0*
_output_shapes
:*
valueBB B 

save/RestoreV2	RestoreV2
save/Constsave/RestoreV2/tensor_namessave/RestoreV2/shape_and_slices*
dtypes
2*
_output_shapes

::

save/AssignAssignBsave/RestoreV2*
use_locking(*
T0*
_class

loc:@B*
validate_shape(*
_output_shapes

:

save/Assign_1AssignWsave/RestoreV2:1*
use_locking(*
T0*
_class

loc:@W*
validate_shape(*
_output_shapes

:
6
save/restore_allNoOp^save/Assign^save/Assign_1
[
save_1/filename/inputConst*
valueB Bmodel*
dtype0*
_output_shapes
: 
r
save_1/filenamePlaceholderWithDefaultsave_1/filename/input*
shape: *
dtype0*
_output_shapes
: 
i
save_1/ConstPlaceholderWithDefaultsave_1/filename*
shape: *
dtype0*
_output_shapes
: 

save_1/StringJoin/inputs_1Const*<
value3B1 B+_temp_ee5a531d9f8e453c9deed8318c615e5f/part*
dtype0*
_output_shapes
: 
{
save_1/StringJoin
StringJoinsave_1/Constsave_1/StringJoin/inputs_1*
N*
_output_shapes
: *
	separator 
S
save_1/num_shardsConst*
value	B :*
dtype0*
_output_shapes
: 
^
save_1/ShardedFilename/shardConst*
dtype0*
_output_shapes
: *
value	B : 

save_1/ShardedFilenameShardedFilenamesave_1/StringJoinsave_1/ShardedFilename/shardsave_1/num_shards*
_output_shapes
: 
g
save_1/SaveV2/tensor_namesConst*
dtype0*
_output_shapes
:*
valueBBBBW
i
save_1/SaveV2/shape_and_slicesConst*
valueBB B *
dtype0*
_output_shapes
:

save_1/SaveV2SaveV2save_1/ShardedFilenamesave_1/SaveV2/tensor_namessave_1/SaveV2/shape_and_slicesBW*
dtypes
2

save_1/control_dependencyIdentitysave_1/ShardedFilename^save_1/SaveV2*
T0*)
_class
loc:@save_1/ShardedFilename*
_output_shapes
: 
£
-save_1/MergeV2Checkpoints/checkpoint_prefixesPacksave_1/ShardedFilename^save_1/control_dependency*
N*
_output_shapes
:*
T0*

axis 

save_1/MergeV2CheckpointsMergeV2Checkpoints-save_1/MergeV2Checkpoints/checkpoint_prefixessave_1/Const*
delete_old_dirs(

save_1/IdentityIdentitysave_1/Const^save_1/MergeV2Checkpoints^save_1/control_dependency*
T0*
_output_shapes
: 
j
save_1/RestoreV2/tensor_namesConst*
valueBBBBW*
dtype0*
_output_shapes
:
l
!save_1/RestoreV2/shape_and_slicesConst*
valueBB B *
dtype0*
_output_shapes
:

save_1/RestoreV2	RestoreV2save_1/Constsave_1/RestoreV2/tensor_names!save_1/RestoreV2/shape_and_slices*
_output_shapes

::*
dtypes
2

save_1/AssignAssignBsave_1/RestoreV2*
T0*
_class

loc:@B*
validate_shape(*
_output_shapes

:*
use_locking(

save_1/Assign_1AssignWsave_1/RestoreV2:1*
use_locking(*
T0*
_class

loc:@W*
validate_shape(*
_output_shapes

:
>
save_1/restore_shardNoOp^save_1/Assign^save_1/Assign_1
1
save_1/restore_allNoOp^save_1/restore_shard "B
save_1/Const:0save_1/Identity:0save_1/restore_all (5 @F8"y
trainable_variablesb`
.
W:0W/AssignW/read:02W/initial_value:08
.
B:0B/AssignB/read:02B/initial_value:08"o
	variablesb`
.
W:0W/AssignW/read:02W/initial_value:08
.
B:0B/AssignB/read:02B/initial_value:08*¼
serving_default¨
 
input1
input1:0
 
input2
input2:0"
output1
	output1:0"
output2
	output2:0tensorflow/serving/predict