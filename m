Content-Type: multipart/mixed; boundary="===============1693604242030755102=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: Re: [PATCH 1/4] qmi: add LTE atom driver
Date: Thu, 01 Mar 2018 15:58:11 +0100
Message-ID: <4884d76b-6fe5-bc62-3815-ebf21a333b84@southpole.se>
In-Reply-To: <29677724-540d-a05a-1f0a-2ab53261f44b@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1693604242030755102==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 03/01/2018 03:50 PM, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 03/01/2018 04:48 AM, Jonas Bonn wrote:
>> This patch adds an LTE atom for QMI modems.
>>
>> This atom sets the APN that the LTE default bearer should use when
>> establishing its PDP context.=C2=A0 For the Quectel EC21 that I'm testing
>> with, this is effected by setting the APN on profile ID 1 from which the
>> default settings appear to be taken.=C2=A0 As I don't have any other QMI
>> modem to test with, I can not say for sure that all modems work in this
>> manner.
>>
>> Once configured, the default profile settings are used when the
>> modem connects to the network; for this reason, the LTE atom needs
>> to be instantiated in post_sim, before the modem is set online.
>> ---
>> =C2=A0 Makefile.am=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 drivers/qmimodem/lte.c | 182 =

>> +++++++++++++++++++++++++++++++++++++++++++++++++
>> =C2=A0 2 files changed, 183 insertions(+)
>> =C2=A0 create mode 100644 drivers/qmimodem/lte.c
>>
> =

> Please merge patch 1 & 2 together, that's how we usually do it anyway.

OK.  I broke those up because I thought you were super-pedantic about =

breaking out patches so they were per-file... what's the rule here? =

Per-directory?

> =

>> +struct lte_data {
>> +=C2=A0=C2=A0=C2=A0 struct qmi_service *wds;
>> +=C2=A0=C2=A0=C2=A0 char* apn;
>> +};
> =

> Why do you need the apn?=C2=A0 I don't see it used anywhere.=C2=A0 Also n=
ot our =

> style, should be char *apn.

Ah, right you are... that's a remnant of an earlier approach.  Good catch.

I'll resubmit this shortly.

/Jonas

> =

> The rest looks fine to me.
> =

> Regards,
> -Denis


--===============1693604242030755102==--

