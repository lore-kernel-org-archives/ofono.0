Content-Type: multipart/mixed; boundary="===============6645254043662260431=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH] atmodem: Enable network time for AT modem
Date: Tue, 08 Mar 2011 15:22:11 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802E70715@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1299590181.2828.1.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6645254043662260431==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

ofono-bounces(a)ofono.org wrote:
> Hi Jeevaka,
> =

> On Tue, 2011-03-08 at 12:35 +0200, ext
> Jeevaka.Badrappan(a)elektrobit.com
> wrote:
>> This log is taken some time back. Possible that Network Daylight
>> Saving Time is received as part of the MM information message whereas
>> it may not be in your case.
> =

> If my memory serves, DST is optional in NITZ; only the UTC offset is
> mandatory content. =

> =


Thats what I was referring to in my previous mail indirectly.

"Possible that Network Daylight Saving Time is received as part of the
MM information message whereas
 it may not be in your case." This is due to the fact that DST is
optional element.

CTZDST will be reported only when the Network Daylight Saving Time is
received as part of the
MM information message.

So, the fix seems to be correct.

Regards,
Jeevaka

--===============6645254043662260431==--

