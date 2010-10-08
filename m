Content-Type: multipart/mixed; boundary="===============0725334199345935611=="
MIME-Version: 1.0
From: Moises Silva <moises.silva@gmail.com>
Subject: Re: Using ofono HFP
Date: Fri, 08 Oct 2010 13:59:21 -0400
Message-ID: <AANLkTi=uppgrW4-Q_ZjZU=2QqwGj7jm0kLLyqQ4SDVbq@mail.gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B352DA74327@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0725334199345935611==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 7, 2010 at 11:25 PM, Zhang, Zhenhua <zhenhua.zhang@intel.com>=
 wrote:
>>
>> Where does this 48 comes from? I come from the TDM open source world,
>> where typical configuration for TDM devices is 160 (160 bytes of
>> alaw/ulaw, 160 samples, each 20ms).
>>
>> Is there any way to change that socket MTU to 160 or 320 (depending if
>> it's either SLN16 or alaw/mulaw?
>
> You might want to raise your question on bluez's IRC or mailing list. oFo=
no takes care of call control logic while BlueZ/PulseAudio takes care of SC=
O audio packets.

I will do that. I just thought somebody around here could know.

>> How can I know the format for the audio?
>
> I think it should be PCM raw data from SCO packets but it could wrong may=
be.

Just for the record. I found out the format is SLN16, but the MTU is
fixed and hard-coded in bluez to 48 bytes (that is 24 samples). I
don't know if the format is cell-phone specific or is always SLN16 for
MTU.

Just throwing another question in the air, what should be the best way
to go to use Ofono DBUS API from a C program?

I am trying to write the C version of ./list-modems Python script. I
see in the D-BUS page that they don't recommend using the bare bones
D-BUS C API but rather bindings, like glib bindings. What do you
think? I was trying to use glib for the list-modems C port, but got
stuck on which data type to use for the return value of the GetModems
API.

Thanks,

Moises Silva
Senior Software Engineer
Sangoma Technologies Inc. | 100 Renfrew Drive, Suite 100, Markham ON
L3R 9R6 Canada
t. 1 905 474 1990 x128 | e. moy(a)sangoma.com

--===============0725334199345935611==--

