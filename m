Content-Type: multipart/mixed; boundary="===============8969493217408256819=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/3] modem: Support modem property "AlwaysOnline"
Date: Thu, 28 Mar 2013 11:05:38 -0500
Message-ID: <51546A52.70405@gmail.com>
In-Reply-To: <20130328153635.GK29445@alittletooquiet.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8969493217408256819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Forest,

On 03/28/2013 10:36 AM, Forest Bond wrote:
> Hi Denis,
>
> On Thu, Mar 28, 2013 at 09:55:25AM -0500, Denis Kenzior wrote:
>> Hi Forest,
>>
>> On 03/28/2013 09:22 AM, Forest Bond wrote:
>>> From: Forest Bond<forest.bond@rapidrollout.com>
>>>
>>> ---
>>>   src/modem.c |   15 +++++++++++++--
>>>   1 files changed, 13 insertions(+), 2 deletions(-)
>>>
>>
>> I would actually be okay with this as an interim solution, but see
>> my comments to patch 3.
>
> Great, glad to hear it.
>
> Quick question:  Once this change is in place, set_online is not called f=
or CDMA
> devices.  Should I kill the CDMA-only code paths there?

I don't recall off hand which code paths these are.  Can you elaborate?

Regards,
-Denis

--===============8969493217408256819==--

