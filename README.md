# tunesoup
AutoIT automation script to control REW, miniDSP's, and hometheater hardware and make a 'soup' for configuraiton and calibration, pretty much anthing you want to automate
using AutoIT as the basis, USBDeview to turn on and off sub devices, and minidsp-rs to send configuraitons to the 3 minidsp2x4hd's in my hometheater setup.

TuneSoup allows the control of software that can control USB devices, focusing on the minidsp 2x4HD device initially, with generic enable/disable of multiple devices connected of the USB link, versus using a physical
USB switch that only supports a single unit connected via the USB at a time.
TuneSoup enables the ability to use multiple minidsp devices connected simutaneously to the USB chain on the computer, by enabling and disabling those units not being configured.
Vision : Later version of TuneSoup will include more programs/devices to be controlled, such as Room EQ Wizard, iNuke Amplifier software, and Behringer NX amplifiers, others...
Initial Release will just control miniDSP 2x4-HD. Others can be added later, additionals to include NX series and others such as the behringer iNuke and NX series devices, as they suffer from the same poor programming methods.
Additional device recognition will be done with a simple add a UDF file into the resources to be read as an enumerator for necessary C&C.
