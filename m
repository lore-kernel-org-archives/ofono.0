Content-Type: multipart/mixed; boundary="===============5043445113596817109=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 1/4] bluetooth: Fix reading Bluetooth Adapters
Date: Mon, 17 Dec 2012 11:25:30 -0300
Message-ID: <CAKT1EBf2L0DK3qEW7mX7Z52i2j4Y=rokVsMNzJ_CmiQTXL3pXA@mail.gmail.com>
In-Reply-To: <1353413539-19693-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5043445113596817109==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel:

On Tue, Nov 20, 2012 at 9:12 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This patch replaces GetProperties method by the Get method of the
> object manager to read the available Bluetooth adapters.
> ---
>  plugins/bluetooth.c | 30 ++++++++++++++++++++++--------
>  plugins/bluetooth.h |  2 ++
>  2 files changed, 24 insertions(+), 8 deletions(-)

Please ignore this patch series.

As discussed in the IRC, we will split the Bluetooth/HFP plugins to
keep the compatibility with BlueZ 4 and BlueZ 5. I will send a new
patch series as soon as possible.

Regards,
Claudio.

--===============5043445113596817109==--

