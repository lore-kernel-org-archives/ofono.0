Content-Type: multipart/mixed; boundary="===============1583610079303948645=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [RFC v0 11/13] handsfree-audio: Add sending SCO fd
Date: Mon, 11 Mar 2013 13:36:49 -0300
Message-ID: <CAKT1EBfVkZ7KjzL6o++tENtY=aOGViZv6ZzoNAoTK3om9bdnNQ@mail.gmail.com>
In-Reply-To: <20130311145547.GA28047@x220>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1583610079303948645==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Johan:

On Mon, Mar 11, 2013 at 11:55 AM, Johan Hedberg <johan.hedberg@gmail.com>=
 wrote:
> Hi Claudio,
>
> On Fri, Mar 08, 2013, Claudio Takahasi wrote:
>> This patch adds the call of NewConnection method when the SCO connection
>> is established for HF initiated scenarios.
>> ---
>>  src/handsfree-audio.c | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
>> index f5d0a7b..6fa8b67 100644
>> --- a/src/handsfree-audio.c
>> +++ b/src/handsfree-audio.c
>> @@ -242,12 +242,19 @@ static gboolean sco_connect_cb(GIOChannel *io, GIO=
Condition cond,
>>  {
>>       struct ofono_handsfree_card *card =3D user_data;
>>       DBusMessage *reply;
>> +     int sk;
>>
>>       if (cond & (G_IO_ERR | G_IO_HUP | G_IO_NVAL)) {
>>               reply =3D __ofono_error_failed(card->msg);
>>               goto done;
>>       }
>>
>> +     sk =3D g_io_channel_unix_get_fd(io);
>> +
>> +     send_new_connection(card->path, sk);
>> +
>> +     close(sk);
>> +
>>       reply =3D dbus_message_new_method_return(card->msg);
>
> Shouldn't you be adding a watch for the connected SCO socket instead of
> closing it? Is it not necessary for oFono to know the SCO state? (to
> detect when PA did shutdown() on the socket, return "already connected"
> for Connect(), etc.)

In the current implementation if the user calls Connect and the audio
connection is established already, Handsfree Audio Card returns
'org.ofono.Error.Failed: Operation failed'

In the current API, it is not necessary to track the state or emit
signals. I prefer to keep this simple approach than add additional
logic to track incoming/outgoing SCO connections.
We can improve it later if necessary, as soon as Denis pushes the
basic functionality we can fix the corner cases and issues like this
one.

Regards,
Claudio.

--===============1583610079303948645==--

