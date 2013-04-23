Content-Type: multipart/mixed; boundary="===============3624969923365615675=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 1/7] doc: Add EchoCancelingNoiseReduction to Handsfree
Date: Tue, 23 Apr 2013 10:30:45 -0500
Message-ID: <5176A925.9000406@gmail.com>
In-Reply-To: <1366737703-26883-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3624969923365615675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 04/23/2013 12:21 PM, Claudio Takahasi wrote:
> This patch adds echo canceling and noise reduction property to Handsfree
> interface, allowing the handsfree unit to disable this feature in the
> audio gateway. The HFP spec defines the procedure to turn off echo
> canceling and noise reduction only, it is not allowed to enable this
> feature from the HF unit.
>
> According to Bluetooth HFP 1.6 spec: By default, if the AG supports its
> own embedded echo canceling and/or noise reduction functions, it shall
> have them activated until the AT+NREC command is received from the HF
> unit. From then on, and until the current Service Level Connection is
> dropped for any reason, the AG shall disable these functions every time
> an Audio Connection is established.
> ---
>   doc/handsfree-api.txt | 8 ++++++++
>   1 file changed, 8 insertions(+)
>

All patches in this series have been applied, thanks.

Regards,
-Denis


--===============3624969923365615675==--

