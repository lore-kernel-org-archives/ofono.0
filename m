Content-Type: multipart/mixed; boundary="===============5116333965663014749=="
MIME-Version: 1.0
From: Izhar Mahalalel <izhar.mahalalel@opensynergy.com>
Subject: Port configuration for location services on Telit HE910
Date: Fri, 10 Apr 2015 13:20:26 +0000
Message-ID: <loom.20150410T151424-282@post.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5116333965663014749==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I'm trying to enable the LocationReporting interface in ofono. If I
understood the documentation correctly, in order for this interface to show
up in Manager.GetModems, I need first to send an appropriate AT command to
the device, for it to change to port configuration #8, and then power cycle
the board for changes to take effect.

I have tried the following:

# systemctl stop ofono
# cat /dev/ttyACM3 &
# echo 'AT#PORTCFG=3D8\r' > /dev/ttyACM3

OK

# reboot

But I still do not see the location reporting interface when running
Manager.GetModems:

# dbus-send --print-reply --system --dest=3Dorg.ofono /
org.ofono.Manager.GetModems
method return sender=3D:1.1 -> dest=3D:1.5 reply_serial=3D2
   array [
      struct {
         object path "/he910_1"
         array [
            dict entry(
               string "Online"
               variant                   boolean true
            )
            dict entry(
               string "Powered"
               variant                   boolean true
            )
            dict entry(
               string "Lockdown"
               variant                   boolean false
            )
            dict entry(
               string "Emergency"
               variant                   boolean false
            )
            dict entry(
               string "Manufacturer"
               variant                   string "Telit"
            )
            dict entry(
               string "Model"
               variant                   string "HE910"
            )
            dict entry(
               string "Revision"
               variant                   string "12.00.004"
            )
            dict entry(
               string "Serial"
               variant                   string "357164040701347"
            )
            dict entry(
               string "Interfaces"
               variant                   array [
                     string "org.ofono.NetworkRegistration"
                     string "org.ofono.ConnectionManager"
                     string "org.ofono.CallMeter"
                     string "org.ofono.SupplementaryServices"
                     string "org.ofono.VoiceCallManager"
                     string "org.ofono.CallBarring"
                     string "org.ofono.CallSettings"
                     string "org.ofono.CallForwarding"
                     string "org.ofono.MessageWaiting"
                     string "org.ofono.SimManager"
                  ]
            )
            dict entry(
               string "Features"
               variant                   array [
                     string "net"
                     string "gprs"
                     string "ussd"
                     string "sim"
                  ]
            )
            dict entry(
               string "Type"
               variant                   string "hardware"
            )
         ]
      }
   ]


What am I missing?

Thanks,
Izhar


--===============5116333965663014749==--

