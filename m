Content-Type: multipart/mixed; boundary="===============7539855890925299803=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH_v4 2/8] ppp_net: add ppp_net_suspend_interface() function
Date: Tue, 10 May 2011 09:57:05 +0200
Message-ID: <4DC8EFD1.4070203@linux.intel.com>
In-Reply-To: <4DC7697D.9040006@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7539855890925299803==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 09/05/2011 06:11, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 05/04/2011 10:39 AM, Guillaume Zajac wrote:
>> ---
>>   gatchat/ppp.h     |    1 +
>>   gatchat/ppp_net.c |    9 +++++++++
>>   2 files changed, 10 insertions(+), 0 deletions(-)
>>
> I applied this patch, however I had to fix it slightly afterward:
>
>> @@ -196,3 +196,12 @@ void ppp_net_free(struct ppp_net *net)
>>   	g_free(net->if_name);
>>   	g_free(net);
>>   }
>> +
>> +void ppp_net_suspend_interface(struct ppp_net *net)
>> +{
>> +	if (net =3D=3D NULL || net->channel =3D=3D NULL)
>> +		return;
>> +
>> +	if (net->watch)
>> +		g_source_remove(net->watch);
>> +}
> Whenever removing a watch, please make sure to reset the watch variable
> back to zero.

Yes, sorry I had forgotten this one.

> Also, I'm missing the _resume version of the above function...

I would have implemented in the set of patches for ATO0 callback.

Kind regards,
Guillaume

--===============7539855890925299803==--

