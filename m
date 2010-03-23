Content-Type: multipart/mixed; boundary="===============6517215312521558801=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: Re: [PATCH 08/10] Fix do not emit error if extended error has emitted
Date: Tue, 23 Mar 2010 17:10:06 +0800
Message-ID: <4BA8856E.8000706@intel.com>
In-Reply-To: <201003221327.53092.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6517215312521558801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/23/2010 02:27 AM, Denis Kenzior wrote:
> Hi Zhenhua,
>
>> ---
>>   gatchat/gatserver.c |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
>> index 1ffc2c3..9683fa3 100644
>> --- a/gatchat/gatserver.c
>> +++ b/gatchat/gatserver.c
>> @@ -165,6 +165,10 @@ static void g_at_server_send_final(GAtServer *serve=
r,
>>   GAtServerResult result) char r =3D v250.s4;
>>   	unsigned int len;
>>
>> +	/* Do not emit error if extended error has already been emitted */
>> +	if (result =3D=3D G_AT_SERVER_RESULT_EXT_ERROR)
>> +		return;
>> +
>
> I really don't get it, why would anyone call g_at_server_send_final with
> EXT_ERROR?  Don't we have g_at_server_send_ext_final or something for tha=
t?

I understand your point. My thinking is that callback should return =

GAtServrResult so that the main logic know whether we should parse the =

next command or abort parsing. But if the function call is =

asynchronized, I don't know, do you want send_final able to abort the =

parsing iteration?

>>   	if (v250.quiet)
>>   		return;
>>
>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>


--===============6517215312521558801==--

