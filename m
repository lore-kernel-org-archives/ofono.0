Content-Type: multipart/mixed; boundary="===============0944067627709471508=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Unsalble cellular connection
Date: Mon, 19 Aug 2019 10:17:33 +0200
Message-ID: <b7da36fc-0093-1b54-eb6a-4785c74521d2@norrbonn.se>
In-Reply-To: <CAOf5uw=fQe4cuTfdciqW3hmXHXv-tY2UYd4aLfMVxF5Lx65jbw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0944067627709471508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Michael,

Re-adding JH and mailing lists to conversation...

On 19/08/2019 10:00, Michael Nazzareno Trimarchi wrote:
> Hi
> =

> On Mon, Aug 19, 2019 at 9:51 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>>
>>
>>
>> On 19/08/2019 09:36, Michael Nazzareno Trimarchi wrote:
>>> Can be chattering and rush current? Even are you sure that you don't ha=
ve
>>> some reset our of the ofono service that send an at command that
>>> restart the modem?
>>
>> Just to try to prevent us from going down the wrong rabbit hole here:
>> i)  The modem is a QMI device so there are no AT commands being sent
> =

> Ok, so the uart used as ttyUSB0 and ttyUSB1 they don't support any AT com=
mand?
> Is qmi part only the network interface?

ttyUSB0 and ttyUSB1 _do_ support AT commands, but are complementary to =

the QMI interface which is a complete communication channel to the modem =

in itself.  The network interface is _only_ for the QMI channel:  the =

network packets are carried on a dedicated endpoint of the USB interface =

supporting QMI.

I think the question of QMI vs AT is moot here.  Internally the modem =

does pretty much the same thing; it's just the interface that looks a =

bit different.

In JH's case, only the 'qmimisc' device and the 'network' interface are =

in play via ofono.  These are separate endpoints on a single USB =

interface, all managed by the qmi-wwan driver in the kernel.

/Jonas

--===============0944067627709471508==--

