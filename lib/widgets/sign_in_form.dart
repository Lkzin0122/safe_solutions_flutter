import 'package:flutter/material.dart';

class NavigationPage extends StatefulWidget {
    const NavigationPage({Key? key}) : super(key: key);

    @override
    State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
    int _selectedIndex = 0;

    static final List<Widget> _pages = <Widget>[
        const ProfilePage(),
        const EditProfilePage(),
        const MyContractsPage(),
    ];

    void _onItemTapped(int index) {
        setState(() {
            _selectedIndex = index;
        });
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Navegação'),
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Perfil',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.edit),
                        label: 'Editar Perfil',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.assignment),
                        label: 'Meus Contratos',
                    ),
                ],
            ),
        );
    }
}

class ProfilePage extends StatelessWidget {
    const ProfilePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return const Center(
            child: Text('Página de Perfil'),
        );
    }
}

class EditProfilePage extends StatelessWidget {
    const EditProfilePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return const Center(
            child: Text('Editar Perfil'),
        );
    }
}

class MyContractsPage extends StatelessWidget {
    const MyContractsPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return const Center(
            child: Text('Meus Contratos'),
        );
    }
}