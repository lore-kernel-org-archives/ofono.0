Content-Type: multipart/mixed; boundary="===============7484151601175797608=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Thu, 17 Apr 2014 21:29:59 +0300
Message-ID: <53501DA7.5000301@jolla.com>
In-Reply-To: <534FF5EA.3000900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7484151601175797608==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> Hi Slava,
>
> Please do not top-post on this mailing list.

ah, sorry.

>
> On 04/17/2014 03:24 AM, Slava Monich wrote:
>> Hi Denis,
>> It's for custom provisioning plugins.
>>
>> Service provider name is passed to the provisioning plugin but not used
>> there at all. This patch makes it possible to utilize it for AP matching.
>>
> I still do not understand.  SPN is passed to the provisioning plugin via
> get_settings.  I do not see any need for it to be stored in
> ofono_gprs_provision_data struct.  How is it going to be used by the core?

I agree that there is no need to for it to be returned by the =

provisioning plugin to the core but it's the same structure used by =

mbpi.c to return the result of parsing serviceproviders.xml to the =

provisioning plugin. Side effect of sharing the structure between two =

interfaces.

If instead I changed the interface between mbpi and provisioning plugin =

and kept the interface with the core intact, would that look acceptable =

to you?

Thanks,
-Slava

--===============7484151601175797608==--

