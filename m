Content-Type: multipart/mixed; boundary="===============2191027561165334254=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/6] phonesim: Add call status UI
Date: Mon, 02 May 2011 04:23:51 -0500
Message-ID: <4DBE7827.8030901@gmail.com>
In-Reply-To: <1304327838-11164-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2191027561165334254==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 05/02/2011 04:17 AM, Nicolas Bertrand wrote:
> This  patch introduce a new tab "call" in phonesim UI in order to display=
 calls
> informationsi (id, number, status, name and direction).
> The interface to send CSSU and CSSI notification is now dynamic based on =
the
> type of current calls.
> Fix some coding-style violations.
> =

> Nicolas Bertrand (6):
>   callmanager: Add signal on call status change
>   control: Update UI using call status
>   hardwaremanipulator: add callmanagement method
>   phonesim: Connect call status signal
>   controlbase.ui: Add call mangement tab
>   control: Update call view
> =

>  src/callmanager.cpp         |   22 +++++++
>  src/callmanager.h           |    3 +
>  src/control.cpp             |  140 +++++++++++++++++++++++++++++++++++++=
+-----
>  src/control.h               |    6 ++
>  src/controlbase.ui          |   61 +++++++++++++++++++
>  src/hardwaremanipulator.cpp |    4 +
>  src/hardwaremanipulator.h   |    2 +
>  src/phonesim.cpp            |    2 +
>  8 files changed, 224 insertions(+), 16 deletions(-)

I applied all of the patches in this series, thanks.

Some general comments:

Your logic for enabling CSSI/CSSU buttons is not really correct.  CSSU
notifications (2, 3, 4) can come at any time there is an active/held
call, and not just during MT call setup.

You might also want to move the CSSI/CSSU generator UI elements into the
Call tab.  They logically belong there now.

Regards,
-Denis

--===============2191027561165334254==--

