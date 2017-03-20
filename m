Content-Type: multipart/mixed; boundary="===============7787217055964869504=="
MIME-Version: 1.0
From: Lukasz Nowak <lnowak.tyco@gmail.com>
Subject: Re: Telit LE910V1 - LTE only modem
Date: Mon, 20 Mar 2017 16:46:24 +0000
Message-ID: <a9342863-3841-ee82-b423-4bdb32d26798@gmail.com>
In-Reply-To: <bcefd4c9-3a47-1f6f-b3ac-0e721136fb57@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7787217055964869504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 20/03/17 14:39, Denis Kenzior wrote:
> Hi Lukasz,
> =

> On 03/20/2017 08:19 AM, Lukasz Nowak wrote:
>> Hi Piotr, Denis,
>>
>> With the qmimodem patch I was able to bring the LE910-SVG modem on-line.
>> But I had to do two things:
> =

> So it looks like the LE910 is a Qualcomm chip / firmware, funny.
Yes, it appears to be a Qualcomm chip, but the firmware is a mixture - it h=
as a Telit AT command set, very similar to other Telit modems (only that CR=
EG never goes registered). But it additionally exposes a qmi_wwan usb devic=
e.

> =

>>
>> 1. The gprs driver was never getting attached.
>> a) This statement in src/gprs.c, gprs_netreg_update()
>>     if (ofono_netreg_get_technology(gprs->netreg) =3D=3D
>>             ACCESS_TECHNOLOGY_EUTRAN)
>>         /*
>>          * For LTE we set attached status only on successful
>>          * context activation.
>>          */
>>                 return;
>> means that the gprs->driver_attached is never set to true.
>> If I remove this piece of code, the gprs->driver->set_attached() gets ca=
lled, and that
>> gets everything attached and working.
> =

> Strictly speaking this statement is correct.  In LTE there's really no co=
ncept of 'attached'.  We're attached by the virtue of getting onto the LTE =
network (the default bearer is always available).  So there should be no ne=
ed to explicitly issue a set_attached method.

The current qmimodem code, calls ofono_gprs_status_notify(NETWORK_REGISTRAT=
ION_STATUS_REGISTERED) when it receives a notification from the modem that =
it is fully connected. Is that the correct path to make the gprs context ma=
rked as "attached"?
If that does not happen, all the dbus context APIs just return an error, an=
d as a result, e.g. connman does not enable the cellular service.

I can add a change to qmimodem, which will explicitly ask the modem firmwar=
e if it is connected, from qmi_gprs_probe() rather than waiting on a state =
change notification, which never arrives.
Does that make sense?

How do you usually test such changes for regressions? I do not have any oth=
er QMI modems, to verify if I have broken anything in them or not. I think =
the change should be safe, but I cannot be 100% certain.

> =

>>
>> b) I can see, that another path to it would be:
>> qmimodem/gprs.c create_nas_cb() calls qmi_service_register(QMI_NAS_SS_IN=
FO_IND, ss_info_notify)
>> But then, ss_info_notify() is never called. I think that the modem is qu=
ick enough to register
>> to the network before qmi_service_register(QMI_NAS_SS_INFO_IND) is calle=
d.
>>
>> c) Denis, you mentioned that I need to call ofono_gprs_cid_activated()
>> Which piece of code should do that? qmimodem/network-registration.c or p=
lugins/gobi.c?
>>
> =

> your gprs.c atom driver.
> =

>>
>> 2. qmimodem/network-registration.c:extract_ss_info() seems to be getting=
 a corrupted
>> operator name:
>> plmn->desc_len =3D 3
>> plmn->desc[] =3D { 0x56, 0xfd, 0x15 }
>> The first byte seems correct ('V' for Verizon), but the other two are wr=
ong (later on, dbus
>> aborts the entire ofono process, saying this is not a valid utf-8 string=
).
>> plmn->mcc and plmn->mnc are correct (311:480 - US:Verizon)
>>
>> Have you ever seen anything like that?
>> If I replace the invalid characters, everything works ok. But I imagine =
this is not
>> the right way to handle this.
>>
> =

> I have not played with QMI enough to give any guidance.  You might want t=
o look at libqmi to see if they handle this differently.
I will check libqmi and then propose a patch, sanitizing the operator name =
string.

> =

> Regards,
> -Denis

--===============7787217055964869504==--

