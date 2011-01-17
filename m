Content-Type: multipart/mixed; boundary="===============2674299893195635445=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: Band selection issue
Date: Mon, 17 Jan 2011 08:25:56 -0200
Message-ID: <AANLkTimv00Y2R+g4WkCq9oNBscpBu4secNJY_Ah5rzsq@mail.gmail.com>
In-Reply-To: <B32E3D5F1713054290B4FF257B89C51A29869CE509@shsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2674299893195635445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhigang

On Mon, Jan 17, 2011 at 6:31 AM, Li, Zhigang <zhigang.li@intel.com> wrote:
> Hi Lucas
>
> The issue was unstable modem. I tried the 1552 modem again, now it works =
fine with 2G/3G Band, as the limitation of PCS network, did not test the PC=
S band.
>
> With Emw770, it doesn't work yet, should be modem self issue.
>
>>Could you enable debug and paste the output somewhere?
> .......
> .......
> ofonod[28247]: src/gprs.c:ofono_gprs_status_notify() /huawei2 status 2
> ofonod[28247]: PCUI: < \r\n^BOOT:20294258,0,0,0,29\r\n
> ofonod[28247]: PCUI: > AT^SYSCFG=3D16,3,2a0380,2,4\r

What frequency are you trying to set? Could you verify if it works by
setting both GSM and UMTS frequencies to 'any' ?
It might be a problem that this modem does not accept several
frequencies together (currently we keep the GSM and UMTS values by
making an OR and passing to modem)


regards,
Lucas De Marchi

--===============2674299893195635445==--

