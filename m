Content-Type: multipart/mixed; boundary="===============4381587344783597671=="
MIME-Version: 1.0
From: Clayton Craft <clayton@craftyguy.net>
Subject: Re: nokia-modem (N900) not detected after migration to udevng
Date: Sat, 09 Sep 2017 10:58:05 -0700
Message-ID: <20170909175805.GD3@computer.craftyguy.net>
In-Reply-To: <aedf5713-9a9b-16b1-2a11-06da07ad5a11@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4381587344783597671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ok, now the modem is initializing (after applying 3 patches from
Jonas), I get this seg fault in ofonod when I run the "enable-modem" test
script:


ofonod[1502]: plugins/nokia-gpio.c:phonet_status_cb() Link phonet0 (2) is up
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst_rq", "inactive")
ofonod[1502]: plugins/nokia-gpio.c:gpio_power_state_machine() (POWER_EVENT_=
PHONET_LINK_UP) @ state POWER_STATE_NONE
ofonod[1502]: plugins/n900.c:n900_enable() modem=3D0x586ad0 with 0x586cd0
ofonod[1502]: plugins/nokia-gpio.c:gpio_power_state_machine() (POWER_EVENT_=
ON) @ state POWER_STATE_NONE
ofonod[1502]: plugins/nokia-gpio.c:gpio_power_set_state() (POWER_STATE_ON_S=
TARTED) at (POWER_STATE_NONE)
ofonod[1502]: plugins/nokia-gpio.c:gpio_start_modem_power_on()
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_apeslpx", "inactive")
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst_rq", "inactive")
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_en", "inactive")
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_bsi", "inactive")
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst", "inactive")
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_en", "active")
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst", "active")
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst_rq", "active")
ofonod[1502]: plugins/n900.c:n900_power_cb() power state POWER_STATE_ON_STA=
RTED
ofonod[1502]: plugins/nokia-gpio.c:phonet_status_cb() Link phonet0 (2) is d=
own
ofonod[1502]: plugins/nokia-gpio.c:gpio_power_state_machine() (POWER_EVENT_=
PHONET_LINK_DOWN) @ state POWER_STATE_ON_STARTED
ofonod[1502]: plugins/nokia-gpio.c:phonet_status_cb() Link phonet0 (2) is up
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_rst_rq", "inactive")
ofonod[1502]: plugins/nokia-gpio.c:gpio_power_state_machine() (POWER_EVENT_=
PHONET_LINK_UP) @ state POWER_STATE_ON_STARTED
ofonod[1502]: plugins/nokia-gpio.c:gpio_power_set_state() (POWER_STATE_ON) =
at (POWER_STATE_ON_STARTED)
ofonod[1502]: plugins/nokia-gpio.c:gpio_finish_modem_power_on()
ofonod[1502]: plugins/nokia-gpio.c:gpio_write() ("cmt_en", "inactive")
ofonod[1502]: plugins/nokia-gpio.c:gpio_power_set_state() Power on
ofonod[1502]: plugins/n900.c:n900_power_cb() power state POWER_STATE_ON
ofonod[1502]: plugins/n900.c:mtc_reachable_cb() QSO: PN_MTC [0x15] v018.000
ofonod[1502]: plugins/n900.c:mtc_query_cb() Modem state: current=3DMTC_RF_I=
NACTIVE (0x0A) target=3DMTC_RF_INACTIVE (0x0A)
ofonod[1502]: plugins/n900.c:report_powered() Powered on
ofonod[1502]: examples/emulator.c:powered_watch() Adding modem 0x586ad0 to =
the list
ofonod[1502]: examples/emulator.c:create_tcp() Created server_watch: 40
ofonod[1502]: examples/emulator.c:create_tcp() Created server_watch: 41
ofonod[1502]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[1502]: plugins/n900.c:n900_pre_sim() (0x586ad0) with phonet0
ofonod[1502]: drivers/isimodem/sim.c:sim_reachable_cb() QSO: PN_SIM [0x09] =
v-01.-01
ofonod[1502]: drivers/isimodem/devinfo.c:reachable_cb() QSO: PN_PHONE_INFO =
[0x1B] v008.005
ofonod[1502]: drivers/isimodem/audio-settings.c:isi_call_verify_cb() QSO: P=
N_CALL [0x01] v007.020
ofonod[1502]: drivers/isimodem/voicecall.c:pn_call_verify_cb() QSO: PN_CALL=
 [0x01] v007.020
ofonod[1502]: drivers/isimodem/voicecall.c:pn_modem_call_verify_cb() PN_MOD=
EM_CALL not reachable, removing client
ofonod[1502]: src/sim.c:ofono_sim_add_state_watch() 0x57dfe0
ofonod[1502]: src/sim.c:ofono_sim_add_state_watch() 0x57dfe0
ofonod[1502]: src/sim.c:ofono_sim_add_state_watch() 0x57dfe0
ofonod[1502]: src/sim.c:ofono_sim_add_state_watch() 0x57dfe0
ofonod[1502]: src/sim.c:ofono_sim_add_state_watch() 0x57dfe0
ofonod[1502]: drivers/isimodem/sim.c:sim_resp_status() Request failed: SIM_=
SERV_SIM_NOT_INITIALISED
ofonod[1502]: drivers/isimodem/sim.c:sec_state_resp_cb() SEC_STATE_RESP(cau=
se=3D0x7)
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_server_ready_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_set_passwd_state() new state "none"
ofonod[1502]: Interface org.ofono.AllowedAccessPoints not found on the inte=
rface_list
ofonod[1502]: drivers/isimodem/sim.c:isi_query_locked()
ofonod[1502]: drivers/isimodem/sim.c:isi_query_locked()
ofonod[1502]: drivers/isimodem/sim.c:isi_query_locked()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:sim_ind_cb()
ofonod[1502]: drivers/isimodem/sim.c:isi_read_file_info() Fileid 6FB7 not i=
mplemented
ofonod[1502]: src/voicecall.c:ecc_g2_read_cb() 0
ofonod[1502]: drivers/isimodem/sim.c:isi_read_file_info() Fileid 6FB7 not i=
mplemented
ofonod[1502]: src/voicecall.c:ecc_g3_read_cb() 0
ofonod[1502]: drivers/isimodem/sim.c:check_sec_response() SEC_CODE_STATE_OK=
_RESP

Program received signal SIGSEGV, Segmentation fault.
sim_query_fac_pinlock_cb (error=3D0xbefffb0c, status=3D5758944, data=3D0x8b=
b17444) at src/sim.c:2476
2476		if (sim->state =3D=3D OFONO_SIM_STATE_NOT_PRESENT)
(gdb) bt
#0  sim_query_fac_pinlock_cb (error=3D0xbefffb0c, status=3D5758944, data=3D=
0x8bb17444) at src/sim.c:2476
#1  0x00448dc8 in check_sec_response (msg=3D0xbefffb84, opaque=3D0x585fb0, =
success=3D<optimized out>, failure=3D<optimized out>) at drivers/isimodem/s=
im.c:468
#2  0x004347ec in pending_remove_and_dispatch (op=3D0x587f90, msg=3D0xbefff=
b84) at gisi/modem.c:171
#3  0x00434df8 in service_dispatch (mux=3D<optimized out>, is_indication=3D=
0, msg=3D0xbefffb84) at gisi/modem.c:218
#4  isi_callback (channel=3D0x585580, cond=3D<optimized out>, data=3D<optim=
ized out>) at gisi/modem.c:334
#5  0xb6e892f0 in g_main_context_dispatch () from /usr/lib/libglib-2.0.so.0
#6  0xb6e895c4 in ?? () from /usr/lib/libglib-2.0.so.0
Backtrace stopped: previous frame identical to this frame (corrupt stack?)



On Fri, Sep 08, 2017 at 04:12:25AM +0200, Jonas Bonn wrote:
>On 09/08/2017 03:38 AM, Clayton Craft wrote:
>>Here's the info you requested, please let me know if I can gather
>>anything else to help!
>
>OK, good.  It's not a driver issue in any case.  Now we need to figure =

>out why ofono is rejecting the device.  The debug output from ofonod =

>would be useful.  Try running ofono as:
>
>ofonod -d -n
>
>and paste the output here.
>
>/Jonas
>
>>
>>localhost:/home/user# udevadm info --query all --path =

>>/sys/bus/hsi/devices/n900-modem
>>P: /devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0/n900=
-modem
>>E: DEVPATH=3D/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/=
port0/n900-modem
>>E: DRIVER=3Dnokia-modem
>>E: MODALIAS=3Dhsi:n900-modem
>>E: OFONO_DRIVER=3Dn900
>>E: OFONO_ISI_ADDRESS=3D108
>>E: OF_COMPATIBLE_0=3Dnokia,n900-modem
>>E: OF_COMPATIBLE_N=3D1
>>E: OF_FULLNAME=3D/ocp(a)68000000/ssi-controller(a)48058000/ssi-port(a)480=
5a000/hsi-client
>>E: OF_NAME=3Dhsi-client
>>E: SUBSYSTEM=3Dhsi
>>E: USEC_INITIALIZED=3D337086386
>>
>>localhost:/home/user# udevadm info --attribute-walk --path =

>>/sys/bus/hsi/devices/n900-modem
>>
>>Udevadm info starts with the device specified by the devpath and then
>>walks up the chain of parent devices. It prints for every device
>>found, all possible attributes in the udev rules key format.
>>A rule to match, can be composed by the attributes of the device
>>and the attributes from one single parent device.
>>
>> looking at device '/devices/platform/68000000.ocp/48058000.ssi-controlle=
r/ssi0/port0/n900-modem':
>>   KERNEL=3D=3D"n900-modem"
>>   SUBSYSTEM=3D=3D"hsi"
>>   DRIVER=3D=3D"nokia-modem"
>>
>> looking at parent device =

>>'/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0/port0':
>>   KERNELS=3D=3D"port0"
>>   SUBSYSTEMS=3D=3D""
>>   DRIVERS=3D=3D""
>>
>> looking at parent device =

>>'/devices/platform/68000000.ocp/48058000.ssi-controller/ssi0':
>>   KERNELS=3D=3D"ssi0"
>>   SUBSYSTEMS=3D=3D""
>>   DRIVERS=3D=3D""
>>
>> looking at parent device =

>>'/devices/platform/68000000.ocp/48058000.ssi-controller':
>>   KERNELS=3D=3D"48058000.ssi-controller"
>>   SUBSYSTEMS=3D=3D"platform"
>>   DRIVERS=3D=3D"omap_ssi"
>>   ATTRS{driver_override}=3D=3D"(null)"
>>
>> looking at parent device '/devices/platform/68000000.ocp':
>>   KERNELS=3D=3D"68000000.ocp"
>>   SUBSYSTEMS=3D=3D"platform"
>>   DRIVERS=3D=3D"omap_l3_smx"
>>   ATTRS{driver_override}=3D=3D"(null)"
>>
>> looking at parent device '/devices/platform':
>>   KERNELS=3D=3D"platform"
>>   SUBSYSTEMS=3D=3D""
>>   DRIVERS=3D=3D""
>>
>>-Clayton
>>On Fri, Sep 08, 2017 at 03:29:27AM +0200, Jonas Bonn wrote:
>>>On 09/08/2017 03:17 AM, Clayton Craft wrote:
>>>>This is on HSI bus. I am running ofono on the N900 (not tethering).
>>>
>>>OK, from what I understand, you should be able to find this device =

>>>under /sys/class/net/....
>>>
>>>See if you can find the device there and run:
>>>
>>>udevadm info --query all --path /sys/class/net/....
>>>and
>>>udevadm info --attribute-walk --path /sys/class/net.....
>>>
>>>Post that output here if it's sane so that we can see what info =

>>>udev is giving you for the device.
>>>
>>>/Jonas
>>>
>>>>
>>>>From what I understand, I am loading all of the necessary drivers for
>>>>this to work (nokia-modem, which pulls in its dependencies
>>>>automaticall). As I stated in my original note, before moving 'legacy
>>>>device' initialization to udevng, ofono would at least 'see' the
>>>>modem. The test script 'list-modems' would list it, now it does not
>>>>list anything.
>>>>
>>>>-Clayton
>>>>On Fri, Sep 08, 2017 at 03:13:03AM +0200, Jonas Bonn wrote:
>>>>>On 09/08/2017 02:51 AM, Clayton Craft wrote:
>>>>>>Hi,
>>>>>>I've been debugging why the n900 modem is not recognized by ofono
>>>>>>for a few days now, and have determined that the cause is because the
>>>>>>calls in udevng to udev_device_get_devnode return NULL. It seems that
>>>>>>the nokia-modem driver does not create any device nodes under /dev.
>>>>>
>>>>>What bus does this modem sit on?  Are you running ofono _on_ =

>>>>>the N900 or are you trying to tether the N900 to some system =

>>>>>with ofono?
>>>>>
>>>>>If you are tethering, what udev events do you get when you =

>>>>>plug in the modem?  Try running "udevadm monitor" and watch =

>>>>>what happens when you plug the modem in.
>>>>>
>>>>>Not getting a device node sounds mostly like there's a driver =

>>>>>missing, though...
>>>>>
>>>>>/Jonas
>>>>>
>>>>>>
>>>>>>This seems to be a regression in functionality since the move to
>>>>>>udevng as previous versions of ofono seem to detect the n900 modem
>>>>>>correctly (right before this commit =

>>>>>>3ac449e25fc8cb9880c48b8f309189c6a644f200)
>>>>>>This issue occurs from this commit onwards, including the =

>>>>>>latest commit
>>>>>>as of this mail.
>>>>>>
>>>>>>https://git.kernel.org/pub/scm/network/ofono/ofono.git/tree/plugins/u=
devng.c#n1316
>>>>>>
>>>>>>
>>>>>>
>>>>>>
>>>>>>-Clayton
>>>>>>
>>>>>>_______________________________________________
>>>>>>ofono mailing list
>>>>>>ofono(a)ofono.org
>>>>>>https://lists.ofono.org/mailman/listinfo/ofono
>>>>>
>>>>>
>>>>>_______________________________________________
>>>>>ofono mailing list
>>>>>ofono(a)ofono.org
>>>>>https://lists.ofono.org/mailman/listinfo/ofono
>>>>
>>>>_______________________________________________
>>>>ofono mailing list
>>>>ofono(a)ofono.org
>>>>https://lists.ofono.org/mailman/listinfo/ofono
>>>
>>>
>>>_______________________________________________
>>>ofono mailing list
>>>ofono(a)ofono.org
>>>https://lists.ofono.org/mailman/listinfo/ofono
>>
>>_______________________________________________
>>ofono mailing list
>>ofono(a)ofono.org
>>https://lists.ofono.org/mailman/listinfo/ofono
>
>
>_______________________________________________
>ofono mailing list
>ofono(a)ofono.org
>https://lists.ofono.org/mailman/listinfo/ofono


--===============4381587344783597671==--

