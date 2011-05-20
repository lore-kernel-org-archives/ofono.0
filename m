Content-Type: multipart/mixed; boundary="===============0322990516622509265=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH] emulator: fix dun_ath_cb() not to remove GAtServer
 io_disconnect() CB
Date: Fri, 20 May 2011 10:29:14 +0200
Message-ID: <4DD6265A.3000509@linux.intel.com>
In-Reply-To: <4DD54135.7070709@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0322990516622509265==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 19/05/2011 18:11, Denis Kenzior wrote:
> Hi Guillaume,
>
> On 05/19/2011 08:03 AM, Guillaume Zajac wrote:
>> ---
>>   src/emulator.c |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/src/emulator.c b/src/emulator.c
>> index c17b901..251bed8 100644
>> --- a/src/emulator.c
>> +++ b/src/emulator.c
>> @@ -219,15 +219,19 @@ static void dun_ath_cb(GAtServer *server, GAtServe=
rRequestType type,
>>   		if (val !=3D 0)
>>   			goto error;
>>
>> +		g_at_server_suspend(em->server);
>>   		g_at_ppp_unref(em->ppp);
>>   		em->ppp =3D NULL;
>> +		g_at_server_resume(em->server);
>>
>>   		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
>>   		break;
>>
>>   	case G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY:
>> +		g_at_server_suspend(em->server);
>>   		g_at_ppp_unref(em->ppp);
>>   		em->ppp =3D NULL;
>> +		g_at_server_resume(em->server);
>>
>>   		g_at_server_send_final(server, G_AT_SERVER_RESULT_OK);
>>   		break;
> This really sounds wrong.  I suggest that we not set the disconnect
> function in GAtPPP when unrefing if GAtPPP is currently suspended.

Ok, I will do it like this.
When I will submit the resume functions associated to suspend functions, =

I will also have to take care about suspended state.

Kind regards,
Guillaume

--===============0322990516622509265==--

