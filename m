Content-Type: multipart/mixed; boundary="===============0267478216455920231=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Thu, 28 Mar 2013 15:29:38 +0100
Message-ID: <515453D2.9040404@syscom-instruments.com>
In-Reply-To: <5154070A.9040108@syscom-instruments.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0267478216455920231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 28. 03. 13 10:02, Viallard Anthony wrote:
> On 05. 03. 13 21:43, Denis Kenzior wrote:
>>>
>>> [...]
>>>
>>> Provisioning failed
>>> -------------------------------
>>
>> This should not affect anything, unless your operator requires SMS to be
>> sent over GPRS.
>>
>
> Hi,
>
> I try to find how i can fix the "provisioning failed" message.
>
> Actually, I have always troubles with T-Mobile. I think I need to fix
> this provisioning issue. How can I do this ? I tried to see where this
> provisioning in the source code but I was quickly lost.
>

I think I've found where the issue is. The MCC and MNC can't be =

retrieve. And the cause is the mnc length can't be retrieve in this =

callback:

static void sim_ad_read_cb(int ok, int length, int record,
				const unsigned char *data,
				int record_length, void *userdata)

The call returns at the test "if (!ok)". So, mnt_length stay at 0 and =

next, on IMSI callback, as it doesn't know mnc_length, it doesn't =

extract MCC and MNC.

I don't know why ofono call the callback with ok=3D0. In the log, I see =

the command was successful:

---------------
Mar 28 13:50:05 mr3000 ofonod[6859]: Data: > AT+CRSM=3D192,28589\r
Mar 28 13:50:05 mr3000 ofonod[6859]: Data: < \r\n+CRSM: =

144,0,""\r\n\r\nOK\r\n
---------------

Maybe a clue on my problem... Why ofono says the command failed ?

Regards,
Anthony.

--===============0267478216455920231==--

