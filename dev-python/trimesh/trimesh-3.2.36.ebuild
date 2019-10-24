# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python2_7 python3_6 )
inherit distutils-r1

DESCRIPTION="Python library for loading and using triangular meshes"
HOMEPAGE="https://github.com/mikedh/trimesh"
SRC_URI="https://github.com/mikedh/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="extra"

DEPEND="
	dev-python/numpy[${PYTHON_USEDEP}]
	extra? (
		sci-libs/scipy[${PYTHON_USEDEP}]
		dev-python/networkx[${PYTHON_USEDEP}]
		dev-python/lxml[${PYTHON_USEDEP}]
		dev-python/pyglet[${PYTHON_USEDEP}]
		sci-libs/Shapely[${PYTHON_USEDEP}]
		sci-libs/Rtree[${PYTHON_USEDEP}]
		dev-python/svg-path[${PYTHON_USEDEP}]
		dev-python/sympy[${PYTHON_USEDEP}]
		dev-python/msgpack[${PYTHON_USEDEP}]
		dev-python/pillow[${PYTHON_USEDEP}]
		dev-python/requests[${PYTHON_USEDEP}]
		dev-python/python-xxhash[${PYTHON_USEDEP}]
		dev-python/setuptools[${PYTHON_USEDEP}]
		dev-python/pycollada[${PYTHON_USEDEP}]
		dev-python/chardet[${PYTHON_USEDEP}]
		dev-python/colorlog[${PYTHON_USEDEP}]
	)
"
RDEPEND="${DEPEND}"
BDEPEND=""
