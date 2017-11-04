#!/bin/bash

base=$(echo '$UserBaseDirectory' | math -noprompt | tr -d '"\n')

install -D Fermat.m $base/Applications/Fermat/Fermat.m

if ! grep FermatPath $base/Kernel/init.m >/dev/null; then
	echo >> $base/Kernel/init.m
	echo "\$FermatPath = \"$base/Applications/Fermat\";" >> $base/Kernel/init.m
	echo 'If[Not[MemberQ[$Path,$FermatPath]],$Path = Flatten[{$Path, $FermatPath}]];' >> $base/Kernel/init.m
fi

exit 0

