Content-Type: multipart/mixed; boundary="===============6283960794539137483=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 05/18] gatppp: add g_at_ppp_set_suspend_function()
 definition
Date: Thu, 31 Mar 2011 11:04:00 +0200
Message-ID: <4D944380.60309@linux.intel.com>
In-Reply-To: <4D939895.5070303@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6283960794539137483==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 30/03/2011 22:54, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 03/25/2011 10:25 AM, Guillaume Zajac wrote:
>> ---
>>   gatchat/gatppp.c |    8 ++++++++
>>   1 files changed, 8 insertions(+), 0 deletions(-)
>>
>> diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
>> index 993b5ea..9df6b8e 100644
>> --- a/gatchat/gatppp.c
>> +++ b/gatchat/gatppp.c
>> @@ -467,6 +467,14 @@ void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc f=
unc, gpointer user_data)
>>   	ppp->debug_data =3D user_data;
>>   }
>>
>> +void g_at_ppp_set_suspend_function(GAtPPP *ppp, GAtSuspendFunc func, gp=
ointer user_data)
>> +{
>> +	if (ppp =3D=3D NULL)
>> +		return;
>> +
>> +	g_at_hdlc_set_suspend_function(ppp->hdlc, func, user_data);
>> +}
>> +
> This is really not enough, you must also shut down the read watch on the
> TUN device, so that we don't try to forward packets from TUN to HDLC
> while we're suspended.
>

I will add into g_at_ppp_suspend():
-->ppp_net_suspend() to shut down read watch

and into g_at_ppp_resume():
-->ppp_net_resume() to resume read watch

Kind regards,
Guillaume


--===============6283960794539137483==--

