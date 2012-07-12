Content-Type: multipart/mixed; boundary="===============2682152895948452093=="
MIME-Version: 1.0
From: Simon Busch <morphis@gravedo.de>
Subject: Re: [PATCH] control: use correct dbus error domain
Date: Thu, 12 Jul 2012 18:33:36 +0200
Message-ID: <4FFEFC60.4040303@gravedo.de>
In-Reply-To: <4FFEF8A2.1050108@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2682152895948452093==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Am 12.07.2012 18:17, schrieb Denis Kenzior:
> Hi Simon,
>
> On 07/12/2012 03:06 AM, Simon Busch wrote:
>> Before it was org.ofono.phonesimError but should be consistent with
>> the other error
>> reports and should use org.ofono.phonesim.Error.
>>
>> Signed-off-by: Simon Busch<morphis@gravedo.de>
>
> Please note that we do not use Signed-off-by


Ok, will consider this the next time.

>> ---
>>   src/control.cpp |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>
> Patch has been applied, thanks.

Thanks a lot.

regards,
Simon

-- =

Simon Busch - http://mm.gravedo.de/blog/



--===============2682152895948452093==--

