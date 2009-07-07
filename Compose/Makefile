Compose_neo_math.neo: Compose.neo Compose_math_and_physics.neo
	cat $? > $@
	echo >> $@
	echo "# End of Definitions by Neo keyboard layout" >> $@

Compose_neo_greek.neo: Compose.neo Compose_greek.neo
	cat $? > $@
	echo >> $@
	echo "# End of Definitions by Neo keyboard layout" >> $@

Compose_neo_math_sprachen.neo: Compose.neo Compose_math_and_physics.neo Compose_greek.neo Compose_sprachen.neo
	cat $? > $@
	echo >> $@
	echo "# End of Definitions by Neo keyboard layout" >> $@

Compose_neo_sprachen.neo: Compose.neo Compose_greek.neo Compose_sprachen.neo
	cat $? > $@
	echo >> $@
	echo "# End of Definitions by Neo keyboard layout" >> $@

Compose_neo_rom.neo: Compose.neo Compose_many_roman_numericals.neo
	cat $? > $@
	echo >> $@
	echo "# End of Definitions by Neo keyboard layout" >> $@
