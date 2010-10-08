Content-Type: multipart/mixed; boundary="===============8211913387162767903=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [RFC ssn PATCH 1/4] Supplementary Service Notifications
Date: Fri, 08 Oct 2010 18:36:36 +0300
Message-ID: <1286552200-18282-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8211913387162767903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello all,

I've been working on supplementary service notifications (iow, trying to
decipher notifySS usage from 24.080 and related specifications).

SSN atom is not used much, so I ended up modifying the current notifier
API to include the SSN notification codes as a parameter of the notify
function.

I also wrote an isimodem driver for the SSNs. =


As for the D-Bus API, the modifications I propose are in the patch
4. There is no implementation in src/voicecall.c or
src/call-forwarding.c, as I'd like to get the D-Bus API agreed first.

I'd move the barring notifications to voicecall API, as they just
provide additional information on the reason why the call was
rejected. IncomingBarringInEffect is not about your barring services but
barring services for callee.

Most of the CSSI and CSSU indications are no-brainers (once you match
the 27.007 language and various bits and pieces from 24.08*
specifications) from the API point-of-view but these really require a
call ID along with them:

  - call has been put on hold (+CSSU: 2)
  - call has been retrieved (+CSSU: 3), and
  - joining call to a multiparty conference (+CSSU: 4)

The problem here is that the AT CSSI/CSSU notifications conveniently
strip away indication which call is put on hold, retrieved or joined to
a multiparty call.  I'd reuse the index with non-CUG codes (as I did in
isimodem driver patch) or add an extra call-id parameter to the
notifiers.  If the driver does not know call-id or there is no call-id
for the call, it can pass 0 to the core and let the core to select a
convenient victim.

--Pekka



--===============8211913387162767903==--

