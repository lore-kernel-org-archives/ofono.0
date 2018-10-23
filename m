Content-Type: multipart/mixed; boundary="===============1191927207994537516=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] src/modem: connection timeout to 60 seconds
Date: Tue, 23 Oct 2018 10:08:29 -0500
Message-ID: <8d07caca-7a05-5ad7-c17a-81647a2e6d2e@gmail.com>
In-Reply-To: <CAKSBH7FvFdN4Eiv0pFFgWC5EhjEKwM8Wf77ZMare7UZmpc_XiQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1191927207994537516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/23/2018 03:40 AM, Giacinto Cifelli wrote:
> Hi,
> =

> On Tue, Oct 23, 2018 at 10:34 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>>
>> Hi,
>>
>> Do the USB interfaces show up long before the modem is ready to accept
>> AT commands?  Or do the AT commands take a long time to complete?
> =

> The USB shows up long before the modem is ready to accept AT commands,
> and - if supported - the MBIM OPEN takes a long time to complete.
> =


So you really need to have a serious talk to your firmware guys about =

fixing this.  Why is the modem jumping on the bus before it is ready to =

accept AT commands?

In my 10+ years I've never seen a modem do this.  Some take 5 seconds, =

maybe 10.  I've never seen anything more than that, which is why that 20 =

second value was quite conservative when I added it.

Anyhow, go ahead and add ofono_modem_set_powered_timeout_hint(unsigned =

int seconds) and have udevng detection fix this.

Regards,
-Denis

--===============1191927207994537516==--

