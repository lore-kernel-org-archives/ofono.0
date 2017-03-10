Content-Type: multipart/mixed; boundary="===============5956762764766886996=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: problem reading ICCID on Telit modem
Date: Fri, 10 Mar 2017 10:42:41 -0600
Message-ID: <4d71a84c-7346-dd69-1d6c-0e601d363463@gmail.com>
In-Reply-To: <dfbe0476-67c9-b0f5-3792-36d60041d0e0@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5956762764766886996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christophe,

On 03/10/2017 10:13 AM, Christophe Ronco wrote:
> Hi,
>
> I am using a LE910-EU V2 modem (from Telit). I have a SIM card with PIN
> code activated.
>
> With this setup, I never have CardIdentifier property in
> org.ofono.SimManager properties. This is because Ofono fails to read ICCI=
D.
>
>
> In traces, I see all commands AT+CRSM sent during init (before PIN is
> entered) failing. For example:
>
> Aux: > AT+CRSM=3D192,28590\r
> Aux: < \r\n+CME ERROR: 4\r\n
>
>
> I assume this is an intended behavior from Telit as described in their
> AT reference guide (page 124):
>
> https://www.coniugo.de/tl_files/dateien/downloads/at/AT%20Commands%20LE91=
0.pdf
>
>
> The note says:
>
> this command requires PIN authentication.  However commands READ BINARY
> and READ RECORD can be issued before PIN authentication and if the SIM
> is blocked  (after three failed  PIN authentication  attempts) to access
> the contents of the Elementary Files.
>
> 192 is GET RESPONSE, READ BINARY is 176 and READ RECORD is 178
>

The SIM filesystem guarantees that certain files are always readable. =

 From memory this includes EFiccid, EFpl, EFecc and a few others.  Since =

some of these are record based files of variable length (for example =

EFecc) we need to look up the record length first.

Otherwise, as an example, we can't read SIM specific emergency calling =

codes when the SIM PIN hasn't been entered.  Being able to do so is =

mandated by 3GPP.  From memory, EFdir and EFarr should always be =

accessible as well (see ETSI 102.221), so this just seems like a stupid =

limitation.

>
> I tried to manage the modem without Ofono to verify that. Here is what I
> tried:
>
> AT+CPIN?
> +CPIN: SIM PIN
>
> OK
> AT+CRSM=3D192,12258
> ERROR
> AT+CRSM=3D176,12258,0,0,255
> +CRSM: 103,0
>
> OK
> AT+CRSM=3D176,12258,0,0,10
> +CRSM: 144,0,98331002040320818103
>
> OK
> AT+CPIN=3D0000
> OK
> AT+CRSM=3D192,12258
> +CRSM: 144,0,62178202412183022FE28A01058B032F06098002000A880110
>
> OK
>
>
> So I am able to read ICCID before entering PIN code but to do that, I
> need to use AT+CRSM=3D176,12258,.... and not AT+CRSM=3D192,12258 as it is
> done by Ofono.
>
> I had a look at code in src/sim.c and src/simfs.c and it seems that any
> read command will first call at driver level read_file_info and then
> read_file_transparent.
>
> I don't know how to fix that in Ofono code (if it should be fixed).
> Should I call directly read_file_transparent in sim_initialize (instead
> of ofono_sim_read) to get ICCID ? Should I modify ofono_sim_read to use
> read_file_transparent directly (in some cases at least)?
>

EFiccid is special in that it is always 10 bytes, so you could cheat and =

read it directly via read_file_transparent.  Similar to how it is done =

for EFimsi.  However, I don't think this would work for other files, =

e.g. EFecc, etc.

Regards,
-Denis

--===============5956762764766886996==--

