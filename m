Content-Type: multipart/mixed; boundary="===============8159676573304964454=="
MIME-Version: 1.0
From: Paavo Leinonen <paavo.leinonen@tieto.com>
Subject: Selecting multiple radio access technologies in oFono
Date: Mon, 31 Jan 2011 15:59:14 +0200
Message-ID: <4D46C032.60405@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8159676573304964454==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Could it be possible to extend current TechnologyPreference setting in
radio-settings-api in a way which would enable user to limit usage of =

certain
radio accesses? For example user could choose to limit technology usage to
technologies like GSM and UMTS even if the LTE coverage would be available.
Following value could be introduced to current API to enable this kind of
selection:

"gsm"      Only GSM used for radio access.
"umts"     Only UMTS used for radio access.
"gsm_umts" Only GSM or UMTS used for radio access.
"lte"      Only LTE used for radio access.

Other approach could be that we would rephrase existing API so that =

instead of
using "only" LTE, we would use LTE whenever available and some older =

technology
when LTE coverage is lacking. So user would select "highest" allowed radio
access without restrictions to use only one technology which has been =

selected.
This would save us from polluting value selection with options like =

"gsm_umts",
a decision we'd be grateful when we'll run oFono on 10G modems. ;)

Use case for this could be energy conservation. At least I have habit to set
network preference to 'GSM' to conserve battery life when I know I'm =

going to
travel places where 3G coverage is not that good or I'm not going to =

need it.

Br,
Paavo


--===============8159676573304964454==--

