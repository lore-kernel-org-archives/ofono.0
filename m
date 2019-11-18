Content-Type: multipart/mixed; boundary="===============6260554338438143084=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH phonesim 03/13] Port old-style connects
Date: Mon, 18 Nov 2019 14:06:48 -0600
Message-ID: <8f6d7bd9-5e62-8ac5-4e7e-ee2aee228cdc@gmail.com>
In-Reply-To: <20191112213719.9309-4-jbb.prv@gmx.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6260554338438143084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonah,

On 11/12/19 3:37 PM, Jonah Br=C3=BCchert wrote:
> * Update CXX Standard to 14 to be able to use qOverload()
> ---
>   configure.ac        |  4 +--
>   src/callmanager.cpp | 22 ++++++-------
>   src/control.cpp     | 77 +++++++++++++++++++++------------------------
>   src/phonesim.cpp    | 56 +++++++++++++++++----------------
>   src/phonesim.h      |  3 +-
>   5 files changed, 80 insertions(+), 82 deletions(-)
> =


<snip>

> @@ -527,35 +528,36 @@ SimRules::SimRules(qintptr fd, QObject *p,  const Q=
String& filename, HardwareMan
>           machine =3D hmf->create(this, nullptr);
> =

>       if (machine) {
> -        connect(machine, SIGNAL(unsolicitedCommand(QString)),
> -                this, SLOT(unsolicited(QString)));
> -        connect(machine, SIGNAL(command(QString)),
> -                this, SLOT(command(QString)));
> -        connect(machine, SIGNAL(variableChanged(QString,QString)),
> -                this, SLOT(setVariable(QString,QString)));
> -        connect(machine, SIGNAL(switchTo(QString)),
> -                this, SLOT(switchTo(QString)));
> +        connect(machine, &HardwareManipulator::unsolicitedCommand,
> +                this, &SimRules::unsolicited);
> +        connect(machine, &HardwareManipulator::command,
> +                this, &SimRules::command);
> +        connect(machine, &HardwareManipulator::variableChanged,
> +                this, &SimRules::setVariable);
> +        connect(machine, &HardwareManipulator::switchTo,
> +                this, &SimRules::switchTo);
>       }
> =

> +

I squashed this stray whitespace...

>       _callManager =3D new CallManager(this);
> -    connect( _callManager, SIGNAL(send(QString)),
> -             this, SLOT(respond(QString)) );
> -    connect( _callManager, SIGNAL(unsolicited(QString)),
> -             this, SLOT(unsolicited(QString)) );
> -    connect( _callManager, SIGNAL(dialCheck(QString,bool&)),
> -             this, SLOT(dialCheck(QString,bool&)) );
> +    connect( _callManager, &CallManager::send,
> +             this, qOverload<const QString &>( &SimRules::respond ) );
> +    connect( _callManager, &CallManager::unsolicited,
> +             this, &SimRules::unsolicited );
> +    connect( _callManager, &CallManager::dialCheck,
> +             this, &SimRules::dialCheck );
> =

>       if ( machine ) {
> -        connect( machine, SIGNAL(startIncomingCall(QString,QString,QStri=
ng)),
> -                 _callManager, SLOT(startIncomingCall(QString,QString,QS=
tring)) );
> -        connect ( _callManager, SIGNAL( callStatesChanged( QList<CallInf=
o> * ) ),
> -                  machine, SLOT( callManagement( QList<CallInfo> * ) ) );
> -        connect ( machine, SIGNAL( stateChangedToAlerting() ), _callMana=
ger,
> -                SLOT( dialingToAlerting() ) );
> -        connect ( machine, SIGNAL( stateChangedToConnected() ), _callMan=
ager,
> -                SLOT( dialingToConnected() ) );
> -        connect ( machine, SIGNAL( stateChangedToHangup( int ) ), _callM=
anager,
> -                SLOT( hangupRemote( int ) ) );
> +        connect( machine, &HardwareManipulator::startIncomingCall, _call=
Manager,
> +                 qOverload<const QString &, const QString &, const QStri=
ng &>( &CallManager::startIncomingCall ) );
> +        connect ( _callManager, &CallManager::callStatesChanged,
> +                  machine, &HardwareManipulator::callManagement);
> +        connect ( machine, &HardwareManipulator::stateChangedToAlerting,=
 _callManager,
> +                &CallManager::dialingToAlerting );
> +        connect ( machine, &HardwareManipulator::stateChangedToConnected=
, _callManager,
> +                &CallManager::dialingToConnected );
> +        connect ( machine, &HardwareManipulator::stateChangedToHangup, _=
callManager,
> +                &CallManager::hangupRemote );
>       }
> =

>       connect(this,SIGNAL(readyRead()),

... and applied this patch.

Regards,
-Denis
--===============6260554338438143084==--

