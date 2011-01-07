Content-Type: multipart/mixed; boundary="===============0420407916154563567=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RFC PATCH] gprs: add function to handle activated context
Date: Fri, 07 Jan 2011 12:38:17 +0200
Message-ID: <AANLkTi=2RFBCd1ne0DDbijSNUFO41Z4R03f=JX+7U4Zu@mail.gmail.com>
In-Reply-To: <201101071050.03794.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0420407916154563567==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/1/7 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> On Thursday 06 January 2011 02:12:01 ext Marcel Holtmann, you wrote:
>> > If such context is not found create a new one with "Internet" type.
>>
>> I don't really agree that we should create a context if no match is
>> found. I think the better sensible strategy is to hold this information
>> internally and only map it to a context once the user or provisioning
>> creates it.
>
> Indeed. Alternatively, we could have a dedicated type, e.g. "Unknown". Us=
ing
> the Internet type is only likely to confuse the connection manager.

+1

Cheers,
Aki

--===============0420407916154563567==--

