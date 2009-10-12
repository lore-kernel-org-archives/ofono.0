Content-Type: multipart/mixed; boundary="===============0646876718998208145=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: how ofono runs with simulator
Date: Mon, 12 Oct 2009 13:27:56 +0800
Message-ID: <38D9F46DFF92C54980D2F2C1E8EE313001B100E350@pdsmsx503.ccr.corp.intel.com>
In-Reply-To: <4AC4962F.708@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0646876718998208145==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


>-----Original Message-----
>From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Beha=
lf Of
>Jeroen Wouters
>Sent: Thursday, October 01, 2009 7:45 PM
>To: ofono(a)ofono.org
>Subject: Re: how ofono runs with simulator
>
>Gu, Yang wrote:
>> The following steps work for latest 0.4 version:
>>
>> 1. Modify modem.conf to config your simulator
>> # Sample for using phone simulator
>> [phonesim]
>> Driver=3Dphonesim
>> Address=3D127.0.0.1
>> Port=3D12345
>>
>> 2. Start simulator by
>> Phonesim -p 12345 -gui data/moblin.xml
>>
>> 3. Start ofono by
>> ofonod -nd
>>
>> 4. power on the modem
>> dbus-send --system --print-reply --dest=3Dorg.ofono /phonesim0
>org.ofono.Modem.SetProperty string:Powered variant:boolean:true
>
>
>Where can I find the moblin.xml file and the source code for the version o=
f phonesim
>you used?
>I've looked for the xml file, but I can't find it. I've also tried the ste=
ps you describe with
>Ofono 0.6 and the phonesim version I found here:
>https://svn.openmoko.org/trunk/src/host/qemu-neo1973/phonesim/
>and with a couple of other XML response files I found on the net, but what=
ever I do in
>the phonesim GUI, there is no response from Ofono.
>Also, in Ofono, the /phonesim0 modem appears, but only has a
>org.ofono.SimManager interface, no VoiceCallManager.

I'm afraid phonesim hasn't been released, and we are just using the interna=
l one. I guess it will be released soon. =


Regards,
-Yang

--===============0646876718998208145==--

