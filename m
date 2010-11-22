Content-Type: multipart/mixed; boundary="===============8371132143597884383=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Add SIM reset button
Date: Mon, 22 Nov 2010 09:40:45 -0600
Message-ID: <4CEA8EFD.90409@gmail.com>
In-Reply-To: <1289940516-14843-1-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8371132143597884383==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Gustavo,

On 11/16/2010 02:48 PM, Gustavo F. Padovan wrote:
> +CRST now send a reset resquest command
> ---
>  src/control.cpp    |    6 ++++++
>  src/control.h      |    1 +
>  src/controlbase.ui |   40 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 47 insertions(+), 0 deletions(-)
> =

> diff --git a/src/control.cpp b/src/control.cpp
> index ab71752..014e657 100644
> --- a/src/control.cpp
> +++ b/src/control.cpp
> @@ -84,6 +84,7 @@ ControlWidget::ControlWidget(const QString &ruleFile, C=
ontrol *parent)
>      connect(ui->cbSimInserted, SIGNAL(clicked()), this, SLOT(simInsertRe=
move()));
>      connect(ui->pbStart, SIGNAL(clicked()), this, SLOT(simAppStart()));
>      connect(ui->pbAbort, SIGNAL(clicked()), this, SLOT(simAppAbort()));
> +    connect(ui->pbReset, SIGNAL(clicked()), this, SLOT(simAppReset()));
>  =

>      QStringList headers;
>      headers << "Sender" << "Priority" << "Notification Status";
> @@ -466,6 +467,11 @@ void ControlWidget::simAppAbort()
>      p->simAppAbort();
>  }
>  =

> +void ControlWidget::simAppReset()

Can you rename this slot into modemSilentReset or something?  This
really has nothing to do with the SIM Application.

> +{
> +    emit unsolicitedCommand("+CRST:");
> +}
> +
>  Script::Script(QObject *obj, Ui_ControlBase *ui) : QDBusAbstractAdaptor(=
obj)
>  {

Otherwise looks good

Regards,
-Denis

--===============8371132143597884383==--

