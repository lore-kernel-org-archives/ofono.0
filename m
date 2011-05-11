Content-Type: multipart/mixed; boundary="===============1833870241865227026=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/5] Introduce call management buttons
Date: Wed, 11 May 2011 14:04:33 -0500
Message-ID: <4DCADDC1.50201@gmail.com>
In-Reply-To: <1305114407-23796-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1833870241865227026==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 05/11/2011 06:46 AM, Nicolas Bertrand wrote:
> This patch add support of call state management.
> Buttons Alerting and Active permit to change the state of on-going call.
> =

> Nicolas Bertrand (5):
>   controlbase: Add call state management buttons
>   hardwaremanipulator: Call state changed signals
>   callmanager: Change call state management slots
>   control: handle call management buttons
>   phonesim: connect call mangagement signals
> =

>  src/callmanager.cpp       |    7 +++++++
>  src/callmanager.h         |   12 ++++++------
>  src/control.cpp           |   12 ++++++++++++
>  src/control.h             |    2 ++
>  src/controlbase.ui        |   18 ++++++++++++++++++
>  src/hardwaremanipulator.h |    2 ++
>  src/phonesim.cpp          |    4 ++++
>  7 files changed, 51 insertions(+), 6 deletions(-)
> =


I applied all patches in this series, however calls still proceed to
Alerting / Active state automagically.  Are there plans to fix that?

Regards,
-Denis

--===============1833870241865227026==--

