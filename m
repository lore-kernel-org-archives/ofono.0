Content-Type: multipart/mixed; boundary="===============7007382460490392801=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH v2 2/6] gatchat: Add g_at_chat_send_full.
Date: Tue, 11 May 2010 00:45:35 +0200
Message-ID: <AANLkTimad9xDirmjF1WHzrb6Qu6b39plcgRki-eq7rLF@mail.gmail.com>
In-Reply-To: <201005101413.09271.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7007382460490392801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 10 May 2010 21:13, Denis Kenzior <denkenz@gmail.com> wrote:
>> g_at_chat_send_full takes two additional parameters compared to
>> g_at_chat_send. =C2=A0The destroy notification is removed from
>> g_at_chat_send and users updated.
>> ---
>
> You stated earlier that the modem will return an error and not time out. =
=C2=A0If
> this is the case then I'm really failing to see the point of needing the
> submit callback.

I stated that as en example of an incompliant modem.  The specs are
not very clear here but say that we should assume the modem is dead if
no response to the AT+CSIM is sent within a timeout of at least 5
seconds.

My thinking so far was that ofono should support an (imaginary) modem
that's described by the specs, and on top of that add support for
vendor specific things, but maybe that is useless in this case.  What
do you think?

Best regards

--===============7007382460490392801==--

