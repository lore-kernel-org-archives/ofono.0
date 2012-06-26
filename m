Content-Type: multipart/mixed; boundary="===============4823608897942619565=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 2/2] emulator: Fix crash when dundee is disconnecting
Date: Tue, 26 Jun 2012 10:00:25 +0200
Message-ID: <4FE96C19.6090700@linux.intel.com>
In-Reply-To: <4FE422BC.3040507@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4823608897942619565==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>> Dundee is not waiting to receive the NO CARRIER notification
>> to close the IO channel with oFono so that oFono is trying to
>> send a NO CARRIER although GAtServer is removed.
>> ---
>>   src/emulator.c |    9 ++++++++-
>>   1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/src/emulator.c b/src/emulator.c
>> index c3165eb..cbee6ad 100644
>> --- a/src/emulator.c
>> +++ b/src/emulator.c
>> @@ -101,7 +101,14 @@ static void cleanup_ppp(struct ofono_emulator *em)
>>       em->pns_id =3D 0;
>>
>>       g_at_server_resume(em->server);
>> -    g_at_server_send_final(em->server, G_AT_SERVER_RESULT_NO_CARRIER);
>> +
>> +    /*
>> +     * If GAtServer IO is lost, GAtServer can have been removed
>> +     * through emulator disconnect routine.
>> +     */
>> +    if (em->server !=3D NULL)
>> +        g_at_server_send_final(em->server,
>> +                    G_AT_SERVER_RESULT_NO_CARRIER);
>
> If server is NULL then either it should be a global check like before =

> (prior to proposed patch 1), or you should add a NULL check to =

> g_at_server_send_final itself.

In this specific case the server is removed during g_at_server_resume(), =

so I will add the NULL check into g_at_server_send_final()

>
>>   }
>>
>>   static void ppp_disconnect(GAtPPPDisconnectReason reason, gpointer =

>> user_data)
>
> Regards,
> -Denis
>

Kind regards,
Guillaume

--===============4823608897942619565==--

