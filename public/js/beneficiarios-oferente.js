jQuery('.SinEspacios').keyup(function () {
	this.value = this.value.replace(/([\ \t]+(?=[\ \t])|^\s+|\s+$)/g, '');
});
