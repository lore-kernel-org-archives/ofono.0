Content-Type: multipart/mixed; boundary="===============5731806673713812503=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Where are ofono dbus paths for RSRQ and RSRP?
Date: Thu, 23 Jan 2020 08:19:07 +1100
Message-ID: <CAA=hcWSeZ6dDoz=DTs_e3RM=VkGgReRtD+A_mjGGcxqinjmSuA@mail.gmail.com>
In-Reply-To: <411442f4-07b2-4870-c4c9-ce2e4a747272@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5731806673713812503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 1/23/20, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi,
>
> On 1/21/20 7:56 PM, JH wrote:
>> Hi,
>>
>> I have been looking for getting RSRQ and RSRP values from ofono dbus
>> commands, but I could not find much information how to get RSRQ and
>> RSRP in debus-send commands, which following interface contains RSRQ
>> and RSRP? And how could I access thos RSRQ and RSRP in debus-send?
>
> What exactly is RSRP and RSRQ?  Are you referring to
> ReferenceSignalReceivedQuality and ReferenceSignalReceivedPower on LTE?
> If so, these would be available on the NetworkMonitor interface assuming
> your modem / driver reports these.

Sorry for not being clear. You are right, it is Reference Signal
Received Quality and Reference Signal Received Power.

Yes, my modem / driver reports those values, I can get RSRQ and RSRP
from minicom, but I need to run shell script or program to record
those values automatically.

Sorry, I am still learning dbus command and syntax, can the
NetworkMonitor interface be run via
dbus-send?

I can run:

# dbus-send --system --print-reply --dest=3Dorg.ofono /
org.ofono.Manager.GetModems
method return time=3D1579727365.983663 sender=3D:1.4 -> destination=3D:1.11=
 serial=3D582
   array [
      struct {
         object path "/ubloxqmi_0"
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
               variant                   string "u-blox"
            )
            dict entry(
               string "Model"
               variant                   string "SARA-R410M-02B"
            )
            dict entry(
               string "Revision"
               variant                   string "L0.0.00.00.05.08  1  [Apr =
17 2"
            )
            dict entry(
               string "Serial"
               variant                   string "359215100856781"
            )
            dict entry(
               string "SystemPath"
               variant                   string "/sys/devices/soc0/soc/2100=
000."
            )
            dict entry(
               string "Interfaces"
               variant                   array [
                     string "org.ofono.SmartMessaging"
                     string "org.ofono.PushNotification"
                     string "org.ofono.MessageManager"
                     string "org.ofono.LongTermEvolution"
                     string "org.ofono.NetworkRegistration"
                     string "org.ofono.RadioSettings"
                     string "org.ofono.ConnectionManager"
                     string "org.ofono.NetworkMonitor"
                     string "org.ofono.MessageWaiting"
                     string "org.ofono.AllowedAccessPoints"
                     string "org.ofono.SimManager"
                  ]
            )
            dict entry(
               string "Features"
               variant                   array [
                     string "sms"
                     string "net"
                     string "rat"
                     string "gprs"
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

But I got following command syntax error, what is the correct syntax
to run NetworkMonitor?

# dbus-send --print-reply --system --dest=3Dorg.ofono /ubloxqmi_0
org.ofono.NetworkMonitor.GetProperties

Error org.freedesktop.DBus.Error.UnknownMethod: Method "GetProperties"
with signature "" on interface "org.ofono.NetworkMonitor" doesn't
exist

Thank you.

Kind regards,

- jh
--===============5731806673713812503==--

