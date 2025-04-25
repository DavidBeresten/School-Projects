import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

import java.util.ArrayList;

public class ToDoList {
    int width = 720;
    int height = 1280;

    ArrayList<Task> tasks = new ArrayList<Task>();

    JFrame window = new JFrame("To Do List");
    JLabel titleLabel = new JLabel();
    JPanel titlePanel = new JPanel();
    JPanel taskPanel = new JPanel();
    JPanel buttonsPanel = new JPanel();

    Color myBrown = new Color(128, 54, 8);
    Color myYellow = new Color(156, 126, 9);


    public ToDoList() {
        //Making the app window

        window.setLayout(new BorderLayout());
        taskPanel.setLayout(new BoxLayout(taskPanel, BoxLayout.Y_AXIS));
        window.add(new JScrollPane(taskPanel), BorderLayout.CENTER);
        window.setSize(width, height);
        window.setResizable(false);
        window.setLocationRelativeTo(null);
        window.setDefaultCloseOperation(window.EXIT_ON_CLOSE);
        

        //making title
        titleLabel.setBackground(myBrown);
        titleLabel.setForeground(Color.white);
        titleLabel.setOpaque(true);
        titleLabel.setFont(new Font("Times New Roman", Font.PLAIN, 70));
        titleLabel.setText("Tasks to do!");
        titleLabel.setHorizontalAlignment(JLabel.CENTER);

        //adding title to window
        titlePanel.setLayout(new BorderLayout());
        titlePanel.add(titleLabel);
        window.add(titlePanel, BorderLayout.NORTH);

        //making buttons
        buttonsPanel.setLayout(new GridLayout(1, 1));
        window.add(buttonsPanel, BorderLayout.SOUTH);

        
        JButton button = new JButton();
        String buttonText = "Create";
        button.setFont(new Font("Times New Roman", Font.PLAIN, 40));
        button.setText(buttonText);
        button.setFocusable(false);
        button.setBackground(myBrown);
        button.setForeground(Color.white);
        UIManager.put("Button.select", myBrown);
        buttonsPanel.add(button);

        //adding functionality to the create button
        button.addActionListener(new ActionListener() {
            public void actionPerformed(ActionEvent e){
                JButton button = (JButton) e.getSource();
                String buttonText = button.getText();

                if (buttonText.equals("Create")){
                    String taskName = JOptionPane.showInputDialog(window, "Whats the task: ");
                    if (taskName != null && !taskName.trim().isEmpty()) {
                        Task newTask = new Task(taskName);
                        tasks.add(newTask);
                
                        JLabel taskLabel = new JLabel(newTask.getTaskName());
                        taskLabel.setFont(new Font("Times New Roman", Font.PLAIN, 40));
                        taskLabel.setBackground(myYellow);
                        taskLabel.setForeground(Color.white);
                        taskLabel.setOpaque(true);
                        taskLabel.setHorizontalAlignment(JLabel.CENTER);
                        taskLabel.setAlignmentX(Component.LEFT_ALIGNMENT);

                        //create the delete button
                        JButton deleteButton = new JButton("X");
                        deleteButton.setFocusable(false);
                        deleteButton.setBackground(Color.RED);
                        deleteButton.setForeground(Color.WHITE);
                        deleteButton.setPreferredSize(new Dimension(80, taskLabel.getPreferredSize().height));

                        //now create the container and add both components
                        JPanel taskContainer = new JPanel();
                        taskContainer.setLayout(new BorderLayout());
                        taskContainer.setMaximumSize(new Dimension(Integer.MAX_VALUE, taskLabel.getPreferredSize().height));
                        taskContainer.add(taskLabel, BorderLayout.CENTER);
                        taskContainer.add(deleteButton, BorderLayout.EAST);

                        //add delete button logic
                        deleteButton.addActionListener(new ActionListener() {
                            public void actionPerformed(ActionEvent e) {
                                taskPanel.remove(taskContainer);
                                tasks.remove(newTask);
                                taskPanel.revalidate();
                                taskPanel.repaint();
                            }
                        });

                        //update after logic
                        taskPanel.add(taskContainer);
                        taskPanel.revalidate();
                        taskPanel.repaint();
                    }
                }
            }
        });

            
        

        window.setVisible(true);
    }
    
    
}
