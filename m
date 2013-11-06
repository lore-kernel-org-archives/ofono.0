Content-Type: multipart/mixed; boundary="===============7953095150795282881=="
MIME-Version: 1.0
From: TengChou Yang <threefure@gmail.com>
Subject: regarding to simManager
Date: Tue, 05 Nov 2013 17:35:53 -0800
Message-ID: <CAHtt_wmkN7qBKLJmWoeq1RaRuJ5t37St-3DFdx_bDb2gZPQU4w@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7953095150795282881==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi guys,
I am currently working on option module GTM 661 W.
Please see following log files,
ofonod[1566]: plugins/udevng.c:setup_hso()
/sys/devices/platform/s5p-ehci/usb1/1-1/1-1.1
ofonod[1566]: plugins/udevng.c:setup_hso() /dev/ttyHS0 255/255/255 00
(null) Diagnostic
ofonod[1566]: plugins/udevng.c:setup_hso() /dev/ttyHS1 255/255/255 01
(null) GPS
ofonod[1566]: plugins/udevng.c:setup_hso() /dev/ttyHS2 255/255/255 02
(null) GPS Control
ofonod[1566]: plugins/udevng.c:setup_hso() /dev/ttyHS3 255/255/255 03
(null) Application
ofonod[1566]: plugins/udevng.c:setup_hso() /dev/ttyHS4 255/255/255 04
(null) Control
ofonod[1566]: plugins/udevng.c:setup_hso() hso0 255/255/255 05 (null) (null)
ofonod[1566]: plugins/udevng.c:setup_hso() /dev/ttyHS5 255/255/255 06
(null) Modem
ofonod[1566]: plugins/udevng.c:setup_hso() control=3D/dev/ttyHS4
application=3D/dev/ttyHS3 modem=3D/dev/ttyHS5 network=3Dhso0
ofonod[1566]: src/modem.c:set_modem_property() modem 0x12e978 property
Control
ofonod[1566]: src/modem.c:set_modem_property() modem 0x12e978 property
Application
ofonod[1566]: src/modem.c:set_modem_property() modem 0x12e978 property Modem
ofonod[1566]: src/modem.c:set_modem_property() modem 0x12e978 property
NetworkInterface
ofonod[1566]: src/modem.c:ofono_modem_register() 0x12e978
ofonod[1566]: plugins/hso.c:hso_probe() 0x12e978
ofonod[1566]: src/modem.c:emit_modem_added() 0x12e978
ofonod[1566]: src/modem.c:call_modemwatches() 0x12e978 added:1
ofonod[1566]: plugins/hfp_ag.c:modem_watch() modem: 0x12e978, added: 1
ofonod[1566]: plugins/dun_gw.c:modem_watch() modem: 0x12e978, added: 1
ofonod[1566]: plugins/smart-messaging.c:modem_watch() modem: 0x12e978,
added: 1
ofonod[1566]: plugins/push-notification.c:modem_watch() modem: 0x12e978,
added: 1
ofonod[1566]: plugins/hso.c:hso_enable() 0x12e978
ofonod[1566]: src/modem.c:get_modem_property() modem 0x12e978 property
Control
ofonod[1566]: plugins/hso.c:open_device() Control /dev/ttyHS4
ofonod[1566]: src/modem.c:get_modem_property() modem 0x12e978 property
Application
ofonod[1566]: plugins/hso.c:open_device() Application /dev/ttyHS3
ofonod[1566]: src/modem.c:get_modem_property() modem 0x12e978 property Modem
ofonod[1566]: plugins/hso.c:open_device() Modem /dev/ttyHS5
ofonod[1566]: < ATE0 +CMEE=3D1
ofonod[1566]: < ATE0 +CMEE=3D1
ofonod[1566]: < AT+CFUN=3D4
ofonod[1566]: < AT+CLVL=3D7
ofonod[1566]: plugins/hso.c:cfun_enable()
ofonod[1566]: < AT_OPMN
ofonod[1566]: plugins/hso.c:check_model()
ofonod[1566]: Model is GTM 661 W
ofonod[1566]: < AT_OBLS
ofonod[1566]: plugins/hso.c:sim_status()
ofonod[1566]: plugins/hso.c:sim_status() status sim 1 pb 1 sms 1
ofonod[1566]: src/modem.c:modem_change_state() old state: 0, new state: 1
ofonod[1566]: plugins/hso.c:hso_pre_sim() 0x12e978
ofonod[1566]: < AT+GCAP
ofonod[1566]: < AT+CSCS=3D"GSM"
ofonod[1566]: < AT+CSCS=3D"GSM"
ofonod[1566]: < AT_ODO?
ofonod[1566]: < AT_ODO=3D0
ofonod[1566]: < AT_OPCMENABLE=3D?
ofonod[1566]: plugins/hso.c:hso_set_online() modem 0x12e978 online
ofonod[1566]: < AT+CFUN=3D1
ofonod[1566]: src/sim.c:ofono_sim_add_state_watch() 0x132ce0
ofonod[1566]: src/sim.c:ofono_sim_add_state_watch() 0x132ce0
ofonod[1566]: src/sim.c:ofono_sim_add_state_watch() 0x132ce0
ofonod[1566]: < AT+CGMI
ofonod[1566]: < AT+CRSM=3D192,12258,0,0,255
ofonod[1566]: src/modem.c:common_online_cb() Online in PRE SIM state
ofonod[1566]: < AT+CGMM
ofonod[1566]: plugins/hso.c:opcm_support()
ofonod[1566]: < AT_OPCMENABLE?
ofonod[1566]: plugins/hso.c:opcm_query()
ofonod[1566]: < AT_OPCMENABLE=3D1
ofonod[1566]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
25
ofonod[1566]: < AT+CRSM=3D176,12258,0,0,10
ofonod[1566]: < AT+CGMR
ofonod[1566]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
10
ofonod[1566]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[1566]: < AT+CRSM=3D192,28421,0,0,255
ofonod[1566]: < AT+CGSN
ofonod[1566]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
25
ofonod[1566]: < AT+CRSM=3D176,28421,0,0,10
ofonod[1566]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
10
ofonod[1566]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[1566]: < AT+CRSM=3D192,12037,0,0,255
ofonod[1566]: drivers/atmodem/sim.c:at_crsm_info_cb() crsm_info_cb: 90, 00,
25
ofonod[1566]: < AT+CRSM=3D176,12037,0,0,10
ofonod[1566]: drivers/atmodem/sim.c:at_crsm_read_cb() crsm_read_cb: 90, 00,
10
ofonod[1566]: src/simfs.c:sim_fs_op_read_block_cb() bufoff: 0, dataoff: 0,
tocopy: 10
ofonod[1566]: < AT+CPIN?
ofonod[1566]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
ofonod[1566]: drivers/atmodem/sim.c:at_pin_retries_query()
ofonod[1566]: <  AT+CPINR
ofonod[1566]: < AT+CRSM=3D192,28590,0,0,255
ofonod[1566]: Querying remaining pin retries failed
ofonod[1566]: < AT+CRSM=3D192,28589,0,0,255

Once this happens(ofono stop after AT+CRSM), I can only list the modem with
the feature "sim"

root@g2:~# /usr/lib/ofono/test/list-modems
[ /hso_0 ]
    Features =3D sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.SimManager
    Online =3D 1
    Model =3D GTM661
    Revision =3D 1.8.4.0 (Date: Apr  5 2011, Time: 11:53:13)
    Type =3D hardware
    Serial =3D 356185040663949,NG39BCR2DJ
    Manufacturer =3D Option N.V.
    [ org.ofono.SimManager ]
        Retries =3D
        FixedDialing =3D 0
        SubscriberNumbers =3D
        PreferredLanguages =3D en
        BarredDialing =3D 0
        CardIdentifier =3D 89014104256259017109
        LockedPins =3D
        PinRequired =3D none
        Present =3D 1

If I kill ofonod and run it again, ofono will start working fine,

[ /hso_0 ]
    Features =3D sms gprs cbs net ussd rat sim
    Emergency =3D 0
    Powered =3D 1
    Lockdown =3D 0
    Interfaces =3D org.ofono.SmartMessaging org.ofono.PushNotification
org.ofono.MessageManager org.ofono.ConnectionManager
org.ofono.CellBroadcast org.ofono.NetworkRegistration org.ofono.Phonebook
org.ofono.SupplementaryServices org.ofono.RadioSettings
org.ofono.VoiceCallManager org.ofono.SimManager
    Online =3D 1
    Model =3D GTM661
    Revision =3D 1.8.4.0 (Date: Apr  5 2011, Time: 11:53:13)
    Type =3D hardware
    Serial =3D 356185040663949,NG39BCR2DJ
    Manufacturer =3D Option N.V.
    [ org.ofono.SmartMessaging ]
    [ org.ofono.PushNotification ]
    [ org.ofono.MessageManager ]
        Alphabet =3D default
        UseDeliveryReports =3D 0
        Bearer =3D cs-preferred
        ServiceCenterAddress =3D +13123149810
    [ org.ofono.ConnectionManager ]
        Powered =3D 1
        Attached =3D 1
        Bearer =3D none
        Suspended =3D 0
        RoamingAllowed =3D 0
    [ org.ofono.CellBroadcast ]
        Topics =3D 0-2,24,40,80,100,223
        Powered =3D 0
    [ org.ofono.NetworkRegistration ]
        Status =3D registered
        Strength =3D 51
        Name =3D AT&T
        LocationAreaCode =3D 55598
        Mode =3D auto
        MobileCountryCode =3D 310
        Technology =3D umts
        CellId =3D 58036143
        MobileNetworkCode =3D 410
    [ org.ofono.Phonebook ]
    [ org.ofono.SupplementaryServices ]
        State =3D idle
    [ org.ofono.RadioSettings ]
        TechnologyPreference =3D any
    [ org.ofono.VoiceCallManager ]
        EmergencyNumbers =3D 08 000 999 110 112 911 118 119
    [ org.ofono.SimManager ]
        Retries =3D
        MobileCountryCode =3D 310
        FixedDialing =3D 0
        SubscriberNumbers =3D
        PreferredLanguages =3D en
        BarredDialing =3D 0
        CardIdentifier =3D 89014104256259017109
        LockedPins =3D
        MobileNetworkCode =3D 410
        SubscriberIdentity =3D 310410625901710
        Present =3D 1

Here is my question,
1, why does it happen randomly?
2, what does "Querying remaining pin retries failed" mean? this message is
showing up even when the ofono is working fine.
3, sometimes all the module had been loaded, but the connection manager
will disappear.


Sincerely,
TengChou Yang

--===============7953095150795282881==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgZ3V5cyw8ZGl2PkkgYW0gY3VycmVudGx5IHdvcmtpbmcgb24gb3B0
aW9uIG1vZHVsZSBHVE0gNjYxIFcuPC9kaXY+PGRpdj5QbGVhc2Ugc2VlIGZvbGxvd2luZyBsb2cg
ZmlsZXMsPC9kaXY+PGRpdj48ZGl2Pm9mb25vZFsxNTY2XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1
cF9oc28oKSAvc3lzL2RldmljZXMvcGxhdGZvcm0vczVwLWVoY2kvdXNiMS8xLTEvMS0xLjE8L2Rp
dj4KPGRpdj5vZm9ub2RbMTU2Nl06IHBsdWdpbnMvdWRldm5nLmM6c2V0dXBfaHNvKCkgL2Rldi90
dHlIUzAgMjU1LzI1NS8yNTUgMDAgKG51bGwpIERpYWdub3N0aWM8L2Rpdj48ZGl2Pm9mb25vZFsx
NTY2XTogcGx1Z2lucy91ZGV2bmcuYzpzZXR1cF9oc28oKSAvZGV2L3R0eUhTMSAyNTUvMjU1LzI1
NSAwMSAobnVsbCkgR1BTPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06IHBsdWdpbnMvdWRldm5nLmM6
c2V0dXBfaHNvKCkgL2Rldi90dHlIUzIgMjU1LzI1NS8yNTUgMDIgKG51bGwpIEdQUyBDb250cm9s
PC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjZdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX2hzbygpIC9k
ZXYvdHR5SFMzIDI1NS8yNTUvMjU1IDAzIChudWxsKSBBcHBsaWNhdGlvbjwvZGl2PjxkaXY+b2Zv
bm9kWzE1NjZdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX2hzbygpIC9kZXYvdHR5SFM0IDI1NS8y
NTUvMjU1IDA0IChudWxsKSBDb250cm9sPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06IHBsdWdpbnMv
dWRldm5nLmM6c2V0dXBfaHNvKCkgaHNvMCAyNTUvMjU1LzI1NSAwNSAobnVsbCkgKG51bGwpPC9k
aXY+CjxkaXY+b2Zvbm9kWzE1NjZdOiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX2hzbygpIC9kZXYv
dHR5SFM1IDI1NS8yNTUvMjU1IDA2IChudWxsKSBNb2RlbTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjZd
OiBwbHVnaW5zL3VkZXZuZy5jOnNldHVwX2hzbygpIGNvbnRyb2w9L2Rldi90dHlIUzQgYXBwbGlj
YXRpb249L2Rldi90dHlIUzMgbW9kZW09L2Rldi90dHlIUzUgbmV0d29yaz1oc28wPC9kaXY+Cjxk
aXY+b2Zvbm9kWzE1NjZdOiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAw
eDEyZTk3OCBwcm9wZXJ0eSBDb250cm9sPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06IHNyYy9tb2Rl
bS5jOnNldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVtIDB4MTJlOTc4IHByb3BlcnR5IEFwcGxpY2F0
aW9uPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06IHNyYy9tb2RlbS5jOnNldF9tb2RlbV9wcm9wZXJ0
eSgpIG1vZGVtIDB4MTJlOTc4IHByb3BlcnR5IE1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjZd
OiBzcmMvbW9kZW0uYzpzZXRfbW9kZW1fcHJvcGVydHkoKSBtb2RlbSAweDEyZTk3OCBwcm9wZXJ0
eSBOZXR3b3JrSW50ZXJmYWNlPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06IHNyYy9tb2RlbS5jOm9m
b25vX21vZGVtX3JlZ2lzdGVyKCkgMHgxMmU5Nzg8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogcGx1
Z2lucy9oc28uYzpoc29fcHJvYmUoKSAweDEyZTk3ODwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTY2XTog
c3JjL21vZGVtLmM6ZW1pdF9tb2RlbV9hZGRlZCgpIDB4MTJlOTc4PC9kaXY+PGRpdj5vZm9ub2Rb
MTU2Nl06IHNyYy9tb2RlbS5jOmNhbGxfbW9kZW13YXRjaGVzKCkgMHgxMmU5NzggYWRkZWQ6MTwv
ZGl2PjxkaXY+b2Zvbm9kWzE1NjZdOiBwbHVnaW5zL2hmcF9hZy5jOm1vZGVtX3dhdGNoKCkgbW9k
ZW06IDB4MTJlOTc4LCBhZGRlZDogMTwvZGl2PjxkaXY+Cm9mb25vZFsxNTY2XTogcGx1Z2lucy9k
dW5fZ3cuYzptb2RlbV93YXRjaCgpIG1vZGVtOiAweDEyZTk3OCwgYWRkZWQ6IDE8L2Rpdj48ZGl2
Pm9mb25vZFsxNTY2XTogcGx1Z2lucy9zbWFydC1tZXNzYWdpbmcuYzptb2RlbV93YXRjaCgpIG1v
ZGVtOiAweDEyZTk3OCwgYWRkZWQ6IDE8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogcGx1Z2lucy9w
dXNoLW5vdGlmaWNhdGlvbi5jOm1vZGVtX3dhdGNoKCkgbW9kZW06IDB4MTJlOTc4LCBhZGRlZDog
MTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTY2XTogcGx1Z2lucy9oc28uYzpoc29fZW5hYmxlKCkgMHgx
MmU5Nzg8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3Bl
cnR5KCkgbW9kZW0gMHgxMmU5NzggcHJvcGVydHkgQ29udHJvbDwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjZdOiBwbHVnaW5zL2hzby5jOm9wZW5fZGV2aWNlKCkgQ29udHJvbCAvZGV2L3R0eUhTNDwvZGl2
Pgo8ZGl2Pm9mb25vZFsxNTY2XTogc3JjL21vZGVtLmM6Z2V0X21vZGVtX3Byb3BlcnR5KCkgbW9k
ZW0gMHgxMmU5NzggcHJvcGVydHkgQXBwbGljYXRpb248L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTog
cGx1Z2lucy9oc28uYzpvcGVuX2RldmljZSgpIEFwcGxpY2F0aW9uIC9kZXYvdHR5SFMzPC9kaXY+
PGRpdj5vZm9ub2RbMTU2Nl06IHNyYy9tb2RlbS5jOmdldF9tb2RlbV9wcm9wZXJ0eSgpIG1vZGVt
IDB4MTJlOTc4IHByb3BlcnR5IE1vZGVtPC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjZdOiBwbHVnaW5z
L2hzby5jOm9wZW5fZGV2aWNlKCkgTW9kZW0gL2Rldi90dHlIUzU8L2Rpdj48ZGl2Pm9mb25vZFsx
NTY2XTqgJmx0OyBBVEUwICtDTUVFPTE8YnI+PC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDsg
QVRFMCArQ01FRT0xPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugQVQrQ0ZVTj00PC9kaXY+
PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDsgQVQrQ0xWTD03PGJyPgo8L2Rpdj48ZGl2Pm9mb25vZFsx
NTY2XTogcGx1Z2lucy9oc28uYzpjZnVuX2VuYWJsZSgpPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06
oCZsdDsgQVRfT1BNTjwvZGl2PjxkaXY+b2Zvbm9kWzE1NjZdOiBwbHVnaW5zL2hzby5jOmNoZWNr
X21vZGVsKCk8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogTW9kZWwgaXMgR1RNIDY2MSBXPC9kaXY+
PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugQVRfT0JMUzwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTY2XTog
cGx1Z2lucy9oc28uYzpzaW1fc3RhdHVzKCk8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogcGx1Z2lu
cy9oc28uYzpzaW1fc3RhdHVzKCkgc3RhdHVzIHNpbSAxIHBiIDEgc21zIDE8L2Rpdj48ZGl2Pm9m
b25vZFsxNTY2XTogc3JjL21vZGVtLmM6bW9kZW1fY2hhbmdlX3N0YXRlKCkgb2xkIHN0YXRlOiAw
LCBuZXcgc3RhdGU6IDE8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogcGx1Z2lucy9oc28uYzpoc29f
cHJlX3NpbSgpIDB4MTJlOTc4PC9kaXY+CjxkaXY+b2Zvbm9kWzE1NjZdOqAmbHQ7oEFUK0dDQVA8
L2Rpdj48L2Rpdj48ZGl2PjxkaXY+b2Zvbm9kWzE1NjZdOqAmbHQ7oEFUK0NTQ1M9JnF1b3Q7R1NN
JnF1b3Q7PC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugQVQrQ1NDUz0mcXVvdDtHU00mcXVv
dDs8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTqgJmx0O6BBVF9PRE8/PC9kaXY+PGRpdj5vZm9ub2Rb
MTU2Nl06oCZsdDugQVRfT0RPPTA8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugQVRfT1BD
TUVOQUJMRT0/PC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06IHBsdWdpbnMvaHNvLmM6aHNvX3NldF9v
bmxpbmUoKSBtb2RlbSAweDEyZTk3OCBvbmxpbmU8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTqgJmx0
O6BBVCtDRlVOPTE8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogc3JjL3NpbS5jOm9mb25vX3NpbV9h
ZGRfc3RhdGVfd2F0Y2goKSAweDEzMmNlMDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTY2XTogc3JjL3Np
bS5jOm9mb25vX3NpbV9hZGRfc3RhdGVfd2F0Y2goKSAweDEzMmNlMDwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjZdOiBzcmMvc2ltLmM6b2Zvbm9fc2ltX2FkZF9zdGF0ZV93YXRjaCgpIDB4MTMyY2UwPC9k
aXY+PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugQVQrQ0dNSTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjZd
OqAmbHQ7oEFUK0NSU009MTkyLDEyMjU4LDAsMCwyNTU8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2Nl06
IHNyYy9tb2RlbS5jOmNvbW1vbl9vbmxpbmVfY2IoKSBPbmxpbmUgaW4gUFJFIFNJTSBzdGF0ZTwv
ZGl2PjxkaXY+b2Zvbm9kWzE1NjZdOqAmbHQ7oEFUK0NHTU08L2Rpdj48ZGl2Pm9mb25vZFsxNTY2
XTogcGx1Z2lucy9oc28uYzpvcGNtX3N1cHBvcnQoKTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjZdOqAm
bHQ7oEFUX09QQ01FTkFCTEU/PGJyPjwvZGl2PjxkaXY+Cm9mb25vZFsxNTY2XTogcGx1Z2lucy9o
c28uYzpvcGNtX3F1ZXJ5KCk8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTqgJmx0O6BBVF9PUENNRU5B
QkxFPTE8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Ny
c21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAyNTwvZGl2PjxkaXY+b2Zvbm9kWzE1
NjZdOqAmbHQ7oEFUK0NSU009MTc2LDEyMjU4LDAsMCwxMDwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTY2
XTqgJmx0O6BBVCtDR01SPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06IGRyaXZlcnMvYXRtb2RlbS9z
aW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3JlYWRfY2I6IDkwLCAwMCwgMTA8L2Rpdj48ZGl2
Pm9mb25vZFsxNTY2XTogc3JjL3NpbWZzLmM6c2ltX2ZzX29wX3JlYWRfYmxvY2tfY2IoKSBidWZv
ZmY6IDAsIGRhdGFvZmY6IDAsIHRvY29weTogMTA8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2Nl06oCZs
dDugQVQrQ1JTTT0xOTIsMjg0MjEsMCwwLDI1NTwvZGl2PjxkaXY+b2Zvbm9kWzE1NjZdOqAmbHQ7
oEFUK0NHU048L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0
X2Nyc21faW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAyNTwvZGl2PjxkaXY+b2Zvbm9k
WzE1NjZdOqAmbHQ7oEFUK0NSU009MTc2LDI4NDIxLDAsMCwxMDxicj4KPC9kaXY+PGRpdj5vZm9u
b2RbMTU2Nl06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3Jl
YWRfY2I6IDkwLCAwMCwgMTA8YnI+PC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06IHNyYy9zaW1mcy5j
OnNpbV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6
IDEwPC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugQVQrQ1JTTT0xOTIsMTIwMzcsMCwwLDI1
NTwvZGl2Pgo8ZGl2Pm9mb25vZFsxNTY2XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2Nyc21f
aW5mb19jYigpIGNyc21faW5mb19jYjogOTAsIDAwLCAyNTwvZGl2PjwvZGl2PjxkaXY+PGRpdj5v
Zm9ub2RbMTU2Nl06oCZsdDsgQVQrQ1JTTT0xNzYsMTIwMzcsMCwwLDEwPC9kaXY+PGRpdj5vZm9u
b2RbMTU2Nl06IGRyaXZlcnMvYXRtb2RlbS9zaW0uYzphdF9jcnNtX3JlYWRfY2IoKSBjcnNtX3Jl
YWRfY2I6IDkwLCAwMCwgMTA8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2Nl06IHNyYy9zaW1mcy5jOnNp
bV9mc19vcF9yZWFkX2Jsb2NrX2NiKCkgYnVmb2ZmOiAwLCBkYXRhb2ZmOiAwLCB0b2NvcHk6IDEw
PC9kaXY+PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugQVQrQ1BJTj88L2Rpdj48ZGl2Pm9mb25vZFsx
NTY2XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X2NwaW5fY2IoKSBjcnNtX3Bpbl9jYjogUkVB
RFk8L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTogZHJpdmVycy9hdG1vZGVtL3NpbS5jOmF0X3Bpbl9y
ZXRyaWVzX3F1ZXJ5KCk8L2Rpdj4KPGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugoEFUK0NQSU5SPC9k
aXY+PGRpdj5vZm9ub2RbMTU2Nl06oCZsdDugQVQrQ1JTTT0xOTIsMjg1OTAsMCwwLDI1NTwvZGl2
PjxkaXY+b2Zvbm9kWzE1NjZdOjxmb250IGNvbG9yPSIjZmYwMDAwIj4gUXVlcnlpbmcgcmVtYWlu
aW5nIHBpbiByZXRyaWVzIGZhaWxlZDwvZm9udD48L2Rpdj48ZGl2Pm9mb25vZFsxNTY2XTqgJmx0
O6BBVCtDUlNNPTE5MiwyODU4OSwwLDAsMjU1PC9kaXY+CjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+T25jZSB0aGlzIGhhcHBlbnMob2Zvbm8gc3RvcCBhZnRlciBBVCtDUlNNKSwgSSBjYW4gb25s
eSBsaXN0IHRoZSBtb2RlbSB3aXRoIHRoZSBmZWF0dXJlICZxdW90O3NpbSZxdW90OzwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5yb290QGcyOn4jIC91c3IvbGliL29mb25vL3Rlc3QvbGlz
dC1tb2RlbXM8L2Rpdj48ZGl2PlsgL2hzb18wIF08L2Rpdj4KPGRpdj6gIKAgRmVhdHVyZXMgPSBz
aW08L2Rpdj48ZGl2PqAgoCBFbWVyZ2VuY3kgPSAwPC9kaXY+PGRpdj6gIKAgUG93ZXJlZCA9IDE8
L2Rpdj48ZGl2PqAgoCBMb2NrZG93biA9IDA8L2Rpdj48ZGl2PqAgoCBJbnRlcmZhY2VzID0gb3Jn
Lm9mb25vLlNpbU1hbmFnZXI8L2Rpdj48ZGl2PqAgoCBPbmxpbmUgPSAxPC9kaXY+PGRpdj6gIKAg
TW9kZWwgPSBHVE02NjE8L2Rpdj48ZGl2PqAgoCBSZXZpc2lvbiA9IDEuOC40LjAgKERhdGU6IEFw
ciCgNSAyMDExLCBUaW1lOiAxMTo1MzoxMyk8L2Rpdj4KPGRpdj6gIKAgVHlwZSA9IGhhcmR3YXJl
PC9kaXY+PGRpdj6gIKAgU2VyaWFsID0gMzU2MTg1MDQwNjYzOTQ5LE5HMzlCQ1IyREo8L2Rpdj48
ZGl2PqAgoCBNYW51ZmFjdHVyZXIgPSBPcHRpb24gTi5WLjwvZGl2PjxkaXY+oCCgIFsgb3JnLm9m
b25vLlNpbU1hbmFnZXIgXTwvZGl2PjxkaXY+oCCgIKAgoCBSZXRyaWVzID08L2Rpdj48ZGl2PqAg
oCCgIKAgRml4ZWREaWFsaW5nID0gMDwvZGl2Pgo8ZGl2PqAgoCCgIKAgU3Vic2NyaWJlck51bWJl
cnMgPTwvZGl2PjxkaXY+oCCgIKAgoCBQcmVmZXJyZWRMYW5ndWFnZXMgPSBlbjwvZGl2PjxkaXY+
oCCgIKAgoCBCYXJyZWREaWFsaW5nID0gMDwvZGl2PjxkaXY+oCCgIKAgoCBDYXJkSWRlbnRpZmll
ciA9IDg5MDE0MTA0MjU2MjU5MDE3MTA5PC9kaXY+PGRpdj6gIKAgoCCgIExvY2tlZFBpbnMgPTwv
ZGl2PjxkaXY+oCCgIKAgoCBQaW5SZXF1aXJlZCA9IG5vbmU8L2Rpdj4KPGRpdj6gIKAgoCCgIFBy
ZXNlbnQgPSAxPC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JZiBJIGtpbGwgb2Zvbm9k
IGFuZCBydW4gaXQgYWdhaW4sIG9mb25vIHdpbGwgc3RhcnQgd29ya2luZyBmaW5lLDwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+PGRpdj5bIC9oc29fMCBdoDwvZGl2PjxkaXY+oCCgIEZlYXR1cmVz
ID0gc21zIGdwcnMgY2JzIG5ldCB1c3NkIHJhdCBzaW08L2Rpdj4KPGRpdj6gIKAgRW1lcmdlbmN5
ID0gMDwvZGl2PjxkaXY+oCCgIFBvd2VyZWQgPSAxPC9kaXY+PGRpdj6gIKAgTG9ja2Rvd24gPSAw
PC9kaXY+PGRpdj6gIKAgSW50ZXJmYWNlcyA9IG9yZy5vZm9uby5TbWFydE1lc3NhZ2luZyBvcmcu
b2Zvbm8uUHVzaE5vdGlmaWNhdGlvbiBvcmcub2Zvbm8uTWVzc2FnZU1hbmFnZXIgb3JnLm9mb25v
LkNvbm5lY3Rpb25NYW5hZ2VyIG9yZy5vZm9uby5DZWxsQnJvYWRjYXN0IG9yZy5vZm9uby5OZXR3
b3JrUmVnaXN0cmF0aW9uIG9yZy5vZm9uby5QaG9uZWJvb2sgb3JnLm9mb25vLlN1cHBsZW1lbnRh
cnlTZXJ2aWNlcyBvcmcub2Zvbm8uUmFkaW9TZXR0aW5ncyBvcmcub2Zvbm8uVm9pY2VDYWxsTWFu
YWdlciBvcmcub2Zvbm8uU2ltTWFuYWdlcjwvZGl2Pgo8ZGl2PqAgoCBPbmxpbmUgPSAxPC9kaXY+
PGRpdj6gIKAgTW9kZWwgPSBHVE02NjE8L2Rpdj48ZGl2PqAgoCBSZXZpc2lvbiA9IDEuOC40LjAg
KERhdGU6IEFwciCgNSAyMDExLCBUaW1lOiAxMTo1MzoxMyk8L2Rpdj48ZGl2PqAgoCBUeXBlID0g
aGFyZHdhcmU8L2Rpdj48ZGl2PqAgoCBTZXJpYWwgPSAzNTYxODUwNDA2NjM5NDksTkczOUJDUjJE
SjwvZGl2PjxkaXY+oCCgIE1hbnVmYWN0dXJlciA9IE9wdGlvbiBOLlYuPC9kaXY+CjxkaXY+oCCg
IFsgb3JnLm9mb25vLlNtYXJ0TWVzc2FnaW5nIF08L2Rpdj48ZGl2PqAgoCBbIG9yZy5vZm9uby5Q
dXNoTm90aWZpY2F0aW9uIF08L2Rpdj48ZGl2PqAgoCBbIG9yZy5vZm9uby5NZXNzYWdlTWFuYWdl
ciBdPC9kaXY+PGRpdj6gIKAgoCCgIEFscGhhYmV0ID0gZGVmYXVsdDwvZGl2PjxkaXY+oCCgIKAg
oCBVc2VEZWxpdmVyeVJlcG9ydHMgPSAwPC9kaXY+PGRpdj6gIKAgoCCgIEJlYXJlciA9IGNzLXBy
ZWZlcnJlZDwvZGl2Pgo8ZGl2PqAgoCCgIKAgU2VydmljZUNlbnRlckFkZHJlc3MgPSArMTMxMjMx
NDk4MTA8L2Rpdj48ZGl2PqAgoCBbIG9yZy5vZm9uby5Db25uZWN0aW9uTWFuYWdlciBdPC9kaXY+
PGRpdj6gIKAgoCCgIFBvd2VyZWQgPSAxPC9kaXY+PGRpdj6gIKAgoCCgIEF0dGFjaGVkID0gMTwv
ZGl2PjxkaXY+oCCgIKAgoCBCZWFyZXIgPSBub25lPC9kaXY+PGRpdj6gIKAgoCCgIFN1c3BlbmRl
ZCA9IDA8L2Rpdj4KPGRpdj6gIKAgoCCgIFJvYW1pbmdBbGxvd2VkID0gMDwvZGl2PjxkaXY+oCCg
IFsgb3JnLm9mb25vLkNlbGxCcm9hZGNhc3QgXTwvZGl2PjxkaXY+oCCgIKAgoCBUb3BpY3MgPSAw
LTIsMjQsNDAsODAsMTAwLDIyMzwvZGl2PjxkaXY+oCCgIKAgoCBQb3dlcmVkID0gMDwvZGl2Pjxk
aXY+oCCgIFsgb3JnLm9mb25vLk5ldHdvcmtSZWdpc3RyYXRpb24gXTwvZGl2PjxkaXY+oCCgIKAg
oCBTdGF0dXMgPSByZWdpc3RlcmVkPC9kaXY+CjxkaXY+oCCgIKAgoCBTdHJlbmd0aCA9IDUxPC9k
aXY+PGRpdj6gIKAgoCCgIE5hbWUgPSBBVCZhbXA7VDwvZGl2PjxkaXY+oCCgIKAgoCBMb2NhdGlv
bkFyZWFDb2RlID0gNTU1OTg8L2Rpdj48ZGl2PqAgoCCgIKAgTW9kZSA9IGF1dG88L2Rpdj48ZGl2
PqAgoCCgIKAgTW9iaWxlQ291bnRyeUNvZGUgPSAzMTA8L2Rpdj48ZGl2PqAgoCCgIKAgVGVjaG5v
bG9neSA9IHVtdHM8L2Rpdj48ZGl2PgqgIKAgoCCgIENlbGxJZCA9IDU4MDM2MTQzPC9kaXY+PGRp
dj6gIKAgoCCgIE1vYmlsZU5ldHdvcmtDb2RlID0gNDEwPC9kaXY+PGRpdj6gIKAgWyBvcmcub2Zv
bm8uUGhvbmVib29rIF08L2Rpdj48ZGl2PqAgoCBbIG9yZy5vZm9uby5TdXBwbGVtZW50YXJ5U2Vy
dmljZXMgXTwvZGl2PjxkaXY+oCCgIKAgoCBTdGF0ZSA9IGlkbGU8L2Rpdj48ZGl2PqAgoCBbIG9y
Zy5vZm9uby5SYWRpb1NldHRpbmdzIF08L2Rpdj4KPGRpdj6gIKAgoCCgIFRlY2hub2xvZ3lQcmVm
ZXJlbmNlID0gYW55PC9kaXY+PGRpdj6gIKAgWyBvcmcub2Zvbm8uVm9pY2VDYWxsTWFuYWdlciBd
PC9kaXY+PGRpdj6gIKAgoCCgIEVtZXJnZW5jeU51bWJlcnMgPSAwOCAwMDAgOTk5IDExMCAxMTIg
OTExIDExOCAxMTk8L2Rpdj48ZGl2PqAgoCBbIG9yZy5vZm9uby5TaW1NYW5hZ2VyIF08L2Rpdj48
ZGl2PqAgoCCgIKAgUmV0cmllcyA9PC9kaXY+CjxkaXY+oCCgIKAgoCBNb2JpbGVDb3VudHJ5Q29k
ZSA9IDMxMDwvZGl2PjxkaXY+oCCgIKAgoCBGaXhlZERpYWxpbmcgPSAwPC9kaXY+PGRpdj6gIKAg
oCCgIFN1YnNjcmliZXJOdW1iZXJzID08L2Rpdj48ZGl2PqAgoCCgIKAgUHJlZmVycmVkTGFuZ3Vh
Z2VzID0gZW48L2Rpdj48ZGl2PqAgoCCgIKAgQmFycmVkRGlhbGluZyA9IDA8L2Rpdj48ZGl2PqAg
oCCgIKAgQ2FyZElkZW50aWZpZXIgPSA4OTAxNDEwNDI1NjI1OTAxNzEwOTwvZGl2Pgo8ZGl2PqAg
oCCgIKAgTG9ja2VkUGlucyA9PC9kaXY+PGRpdj6gIKAgoCCgIE1vYmlsZU5ldHdvcmtDb2RlID0g
NDEwPC9kaXY+PGRpdj6gIKAgoCCgIFN1YnNjcmliZXJJZGVudGl0eSA9IDMxMDQxMDYyNTkwMTcx
MDwvZGl2PjxkaXY+oCCgIKAgoCBQcmVzZW50ID0gMTwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+SGVyZSBpcyBteSBxdWVzdGlvbiw8L2Rpdj48ZGl2PjEsIHdoeSBkb2VzIGl0IGhhcHBl
biByYW5kb21seT88L2Rpdj4KPGRpdj4yLCB3aGF0IGRvZXMgJnF1b3Q7UXVlcnlpbmcgcmVtYWlu
aW5nIHBpbiByZXRyaWVzIGZhaWxlZCZxdW90OyBtZWFuPyB0aGlzIG1lc3NhZ2UgaXMgc2hvd2lu
ZyB1cCBldmVuIHdoZW4gdGhlIG9mb25vIGlzIHdvcmtpbmcgZmluZS48L2Rpdj48ZGl2PjMsIHNv
bWV0aW1lcyBhbGwgdGhlIG1vZHVsZSBoYWQgYmVlbiBsb2FkZWQsIGJ1dCB0aGUgY29ubmVjdGlv
biBtYW5hZ2VyIHdpbGwgZGlzYXBwZWFyLjwvZGl2Pgo8ZGl2Pjxicj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PlNpbmNlcmVseSw8L2Rpdj48ZGl2PlRlbmdDaG91IFlhbmc8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48L2Rpdj4K

--===============7953095150795282881==--

