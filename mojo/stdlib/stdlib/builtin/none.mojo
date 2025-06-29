# ===----------------------------------------------------------------------=== #
# Copyright (c) 2025, Modular Inc. All rights reserved.
#
# Licensed under the Apache License v2.0 with LLVM Exceptions:
# https://llvm.org/LICENSE.txt
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ===----------------------------------------------------------------------=== #
"""Defines the builtin `NoneType`.

These are Mojo built-ins, so you don't need to import them.
"""


@register_passable("trivial")
struct NoneType(
    Copyable,
    Defaultable,
    ExplicitlyCopyable,
    Movable,
    Representable,
    Stringable,
    Writable,
):
    """Represents the absence of a value."""

    alias _mlir_type = __mlir_type.`!kgen.none`
    """Raw MLIR type of the `None` value."""

    var _value: Self._mlir_type

    @always_inline("builtin")
    fn __init__(out self):
        """Construct an instance of the `None` type."""
        self._value = None

    @always_inline("builtin")
    @implicit
    fn __init__(out self, value: Self._mlir_type):
        """Construct an instance of the `None` type.

        Args:
            value: The MLIR none type to construct from.
        """
        self._value = value

    @always_inline
    fn copy(self) -> Self:
        """Explicit copy constructor.

        Returns:
            A copy of the value.
        """
        return Self(None)

    @no_inline
    fn __str__(self) -> String:
        """Returns the string representation of `None`.

        Returns:
            `"None"`.
        """
        return "None"

    @no_inline
    fn __repr__(self) -> String:
        """Returns the string representation of `None`.

        Returns:
            `"None"`.
        """
        return "None"

    @no_inline
    fn write_to[W: Writer](self, mut writer: W):
        """Write `None` to a writer stream.

        Parameters:
            W: A type conforming to the Writable trait.

        Args:
            writer: The object to write to.
        """
        writer.write("None")
