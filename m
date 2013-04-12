Content-Type: multipart/mixed; boundary="===============7290574714377648714=="
MIME-Version: 1.0
From: Viallard Anthony <viallard@syscom-instruments.com>
Subject: Re: Randomly SMS sent passes or fails
Date: Fri, 12 Apr 2013 15:08:35 +0200
Message-ID: <51680753.90109@syscom-instruments.com>
In-Reply-To: <51545290.5000804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7290574714377648714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi denis and ofono guys,

On 28. 03. 13 15:24, Denis Kenzior wrote:
>
> Is the modem auto-attaching to GPRS by default? You might want to turn
> off that behavior if posible.
>

I'm still searching why I've issues on SMS with SIM5216 GSM module and =

T-Mobile.

What did you mean by auto-attaching to GPRS by default ?

To bring GPRS up, I configure it and I call =

ConnectionContext.SetProperty with Active=3D1 and then, I've got GPRS.

I dig out this old answer because I searched why in ConnectionManager =

I've got Bearer: "none". Then, I've found a place (in gprs_initialized() =

function) where ofono try to get data bearer. By default, ofono uses =

"AT+CPSB=3D1" and a callback on "+CPSB:" reply.

There haven't "AT+CPSB" command for SIM5216. I thought I needed to add a =

quirk like Telit or Huawai. I searched on internet and found an old =

message from this list ("[PATCH 6/8] gprs: data bearer for telit with =

PSNT") where you, Denis, answer to Christopher Vogl about the data =

bearer quirk which made for telit and wonder :

"Do you really need to query this?  In theory if we are turning off
auto-attach, we should never be in a state where the bearer should be
queried."

So, I don't know if I must add a quirk (there AT+CNSMOD command for =

SIM5216). What does auto-attach mean ?

Regards,
Anthony Viallard.

--===============7290574714377648714==--

