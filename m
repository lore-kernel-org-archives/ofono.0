Content-Type: multipart/mixed; boundary="===============5087839164884714396=="
MIME-Version: 1.0
From: Lasse Kunnasluoto <lasse.kunnasluoto@tieto.com>
Subject: Re: gatchat looses UR code if received while waiting a response
Date: Mon, 21 Feb 2011 13:01:10 +0200
Message-ID: <1298286070.18611.86.camel@lkunnasl-desktop>
In-Reply-To: <1298282692.2519.43.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5087839164884714396==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Mon, 2011-02-21 at 12:04 +0200, Marcel Holtmann wrote:
> Hi Lasse,
> =

> > I've seen an issue in Unsolicited Result code handling in gatchat. If
> > ofono has sent an AT command and is waiting for a response, but modem
> > has sent an UR code just before the AT command reached the modem,
> > gatchat does not handle that UR code correctly (it drops it). =

> > =

> > 27.007 does not restrict UR-sending in the time between AT command and
> > sending final response.
> > =

> > Even modem would not send an UR while an active AT command, this may
> > happen as a command may be on its way to ofono (e.g. in kernel).
> =

> actually GAtChat handles this correctly. Important is what you give as
> valid_resp to g_at_chat_send. If this is NULL, then all lines between
> the command and OK are consumed by the callback of the send command.
> =

agree, but it would require a quite effort to change all the NULLs to
something meaningful + test with various modems.

> > Real example of this happening:
> > ofonod[1388]: Default: > AT+CGMM\r                  =

> > ofonod[1388]: Default: < \r
> > \n*STKI:"D027810301258082028182850A5361756E616C616874698F09013E50726570=
6169641801241F020103"\r\n =

> > ofonod[1388]: Default: < \r\nST-Ericsson Mobile Broadband\r\n\r\nOK\r
> > \n  =

> > =

> > In this case the call back of *STKI was never called.
> > =

> > This is not a modem issue as it has been verified the modem has sent
> > *STKI before AT+CGMM was received.
> =

> I consider this a modem issue. It should not send *STKI during a AT+CGMM
> command to avoid any kind of confusion of the parser.
> =

This specific case is not a modem issue. Modem has not received AT+CGMM
when it sent *STKI (This was verified from modem logs). Modem cannot
predict that there is AT+CGMM coming. Command was sent exactly same time
on modem and ofono side. =


This is timing depend issue and in my opinion may occur with any AT
modem. Ofono and Modem states are not always the same as there is
certain delay when commands are exchanged between ofono and modem. These
issues may be hidden most of the time but may cause some nasty errors
some day.

> > One way to solve this is to change the sequence in gatchat.c/have_line()
> > a bit and check first if this is UR code and then proceeding to response
> > handling. Would this be acceptable solution for this issue or would it
> > cause some drawbacks? If it is okay I can submit a patch
> =

> See my command above. GAtChat is operating just fine.
> =

More robust solution would be to change GAtChat than defining and
finding valid_resps for tens or hundreds of AT commands. I want to point
out that this is not only an issue with CGMM but may occur with any AT
command when the timing matches.

BR,
-Lasse

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



--===============5087839164884714396==--

