# -*- coding: utf-8 -*-
#
# Copyright (c) 2011 Pawel Szostek (pawel.szostek@cern.ch)
#
#    This source code is free software; you can redistribute it
#    and/or modify it in source code form under the terms of the GNU
#    General Public License as published by the Free Software
#    Foundation; either version 2 of the License, or (at your option)
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
#
SRC := configparser.py connection.py dep_solver.py fetch.py\
flow.py flow_altera.py global_mod.py hdlmake_kernel.py\
__main__.py makefile_writer.py manifest_parser.py module.py msg.py path.py \
srcfile.py

PREFIX := src

ARCH := hdlmake

$(ARCH): $(foreach src, $(SRC), $(PREFIX)/$(src)) Makefile
	bash embed_build_id.sh
	cd $(PREFIX) &&\
	zip $(ARCH) $(SRC) &&\
	echo '#!/usr/bin/python' > $(ARCH) &&\
	cat $(ARCH).zip >> $(ARCH) &&\
	rm $(ARCH).zip &&\
	mv $(ARCH) ..
	chmod +x $(ARCH)

clean:
	rm -f $(PREFIX)/*~ $(PREFIX)/*pyc