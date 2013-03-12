Content-Type: multipart/mixed; boundary="===============6452508614355124632=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 13/15] handsfree-audio: Return InProgress on Connect
Date: Tue, 12 Mar 2013 14:26:09 -0300
Message-ID: <CAKT1EBcD_ajWvo23bQG2XnnyCwbfsoBKTdxuK+xLHpygh9F1SA@mail.gmail.com>
In-Reply-To: <513F493E.9090104@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6452508614355124632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic:

On Tue, Mar 12, 2013 at 12:26 PM, Frederic Danis
<frederic.danis@linux.intel.com> wrote:
> Hello Claudio,
>
>
> On 12/03/2013 13:42, Claudio Takahasi wrote:
>>
>> This patch returns "Operation already in progress" if there is a
>> pending Handsfree Audio Card "Connect" method call pending.
>> ---
>>   src/handsfree-audio.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
>> index 8950347..805f3b6 100644
>> --- a/src/handsfree-audio.c
>> +++ b/src/handsfree-audio.c
>> @@ -285,6 +285,9 @@ static DBusMessage *card_connect(DBusConnection *con=
n,
>>         if (agent =3D=3D NULL)
>>                 return __ofono_error_not_available(msg);
>>
>> +       if (card->msg)
>> +               return __ofono_error_busy(msg);
>> +
>>         sk =3D driver->audio_connect(card->remote, card->local);
>>         if (sk < 0)
>>                 return __ofono_error_failed(msg);
>>
>
> Shouldn't you also test if there is already a SCO connection (sco_watch) ?
> I think that only one SCO link can be connected at a time for a Handsfree
> Audio Card.
>
> Regards
>
> Fred

It is equivalent to check for card->sco_watch or card->msg.

card->sco_watch monitors the SCO connection attempt only.
At the moment, oFono  is not keeping the SCO socket reference after
passing it to the Agent(P.A.).

Regards,
Claudio

--===============6452508614355124632==--

