Content-Type: multipart/mixed; boundary="===============0760040449955924776=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2] simauth: Update simauth to handle AUTS parameter
Date: Fri, 20 Oct 2017 14:07:46 -0500
Message-ID: <fc79bd8f-cc3a-9364-8a34-a4c4536bdf3d@gmail.com>
In-Reply-To: <1508523748-4621-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0760040449955924776==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 10/20/2017 01:22 PM, James Prestwood wrote:
> The support for an invalid SQN number was incomplete in the
> simauth module. The SIM should have an internal SQN stored
> (default.xml now) and verify that the SQN in AUTN matches.
> If not, then generate AUTS and send that back.
> ---
>   src/default.xml |  2 +-
>   src/simauth.cpp | 77 ++++++++++++++++++++++++++++++++++++++++++--------=
-------
>   src/simauth.h   |  3 +++
>   3 files changed, 61 insertions(+), 21 deletions(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0760040449955924776==--

